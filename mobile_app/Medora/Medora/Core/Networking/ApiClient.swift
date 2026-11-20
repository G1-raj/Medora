//
//  ApiClient.swift
//  Medora
//
//  Created by Govine Rajput on 20/11/26.
//

import Foundation

nonisolated struct SuccessResponseModel<T: Decodable & Sendable>: Decodable, Sendable {
    var success: Bool
    var data: T?
    var message: String
}

nonisolated struct RefreshTokenResponseModel: Decodable, Sendable {
    var accessToken: String
}

protocol ApiClientProtocol: Sendable {
    
    func get<T: Decodable & Sendable>(
        _ type: T.Type,
        from url: URL,
        auth: AuthRequirement
    ) async throws -> T
    
    func post<T: Decodable & Sendable, Body: Encodable & Sendable>(
        _ type: T.Type,
        to url: URL,
        body: Body,
        auth: AuthRequirement
    ) async throws -> T
    
    func post<T:Decodable & Sendable>(
        _ type: T.Type,
        to url: URL,
        auth: AuthRequirement
    ) async throws -> T
    
    func put<T: Decodable & Sendable, Body: Encodable & Sendable>(
        _ type: T.Type,
        to url: URL,
        body: Body,
        auth: AuthRequirement
    ) async throws -> T
    
    func patch<T: Decodable & Sendable, Body: Encodable & Sendable>(
        _ type: T.Type,
        to url: URL,
        body: Body,
        auth: AuthRequirement
    ) async throws -> T
    
    func delete(
        from url: URL,
        auth: AuthRequirement
    ) async throws
}


nonisolated final class ApiClient: ApiClientProtocol {
    
    private let session: URLSession
    private let tokenManager: any TokenManagerProtocol
    private let refreshUrl: URL
    
    init(session: URLSession = .shared, tokenManager: TokenManagerProtocol, refreshUrl: URL) {
        self.session = session
        self.tokenManager = tokenManager
        self.refreshUrl = refreshUrl
    }
    
    //get request client
    func get<T: Decodable & Sendable>(_ type: T.Type, from url: URL, auth: AuthRequirement = .none) async throws -> T {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return try await perform(
            request,
            auth: auth
        )
    }
    
    //post client with body to upload the data on server
    func post<T: Decodable & Sendable, Body: Encodable & Sendable>(
        _ type: T.Type,
        to url: URL,
        body: Body,
        auth: AuthRequirement
    ) async throws -> T {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        request.httpBody = try JSONEncoder().encode(body)
        
        return try await perform(
            request,
            auth: auth
        )
    }
    
    //post client without body
    func post<T: Decodable & Sendable>(
        _ type: T.Type,
        to url: URL,
        auth: AuthRequirement = .accessToken
    ) async throws -> T {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        return try await perform(
            request,
            auth: auth
        )
    }
    
    //put client to make put request
    func put<T: Decodable & Sendable, Body: Encodable & Sendable>(
        _ type: T.Type,
        to url: URL,
        body: Body,
        auth: AuthRequirement = .accessToken
    ) async throws -> T {
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        request.httpBody = try JSONEncoder().encode(body)
        
        return try await perform(
            request,
            auth: auth
        )
    }
    
    //patch client to make patch request
    func patch<T: Decodable & Sendable, Body: Encodable & Sendable>(
        _ type: T.Type,
        to url: URL,
        body: Body,
        auth: AuthRequirement = .accessToken
    ) async throws -> T {
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        request.httpBody = try JSONEncoder().encode(body)
        
        return try await perform(
            request,
            auth: auth
        )
    }
    
    //delete client to make delete request
    func delete(from url: URL, auth: AuthRequirement = .accessToken) async throws {
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        _ = try await execute(
            request,
            auth: auth
        )
    }
    
    private func perform<T: Decodable & Sendable>(_ request: URLRequest, auth: AuthRequirement) async throws -> T {
        
        let (data, _) = try await execute(request, auth: auth)
        
        do {
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            return try decoder.decode(T.self, from: data)
            
        } catch let error as DecodingError {
            throw ApiError.decodingError
        }
    }
    
    private func execute(
        _ originalRequest: URLRequest,
        auth: AuthRequirement,
        retryOnUnauthorized: Bool = true
    ) async throws -> (Data, HTTPURLResponse) {
        
        var request = originalRequest
        
        let tokenUsed = try await applyAuthentication(
            to: &request,
            auth: auth
        )
        
        do {
            
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ApiError.invalidResponse
            }
            
            if httpResponse.statusCode == 401, auth == .accessToken, retryOnUnauthorized {
                
                guard let failedToken = tokenUsed else {
                    throw ApiError.invalidResponse
                }
                
                let newToken = try await tokenManager.refreshIfNeeded(failedToken: failedToken) {
                    try await self.refreshAccessToken()
                }
                
                var retryRequest = originalRequest
                
                retryRequest.setValue(
                    "Bearer \(newToken)",
                    forHTTPHeaderField: "Authorization"
                )
                
                return try await execute(retryRequest, auth: .accessToken, retryOnUnauthorized: false)
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                throw ApiError.serverError(httpResponse.statusCode)
            }
            
            return (data, httpResponse)
            
        } catch let error as ApiError {
            throw error
        } catch {
            throw ApiError.networkError(error)
        }
    }
    
    
    private func applyAuthentication(to request: inout URLRequest, auth: AuthRequirement) async throws -> String? {
        switch auth {
        case .none:
            request.setValue(
                nil,
                forHTTPHeaderField: "Authorization"
            )
            
            return nil
            
        case .accessToken:
            guard let token = try await tokenManager.getAccessToken(), !token.isEmpty else {
                throw ApiError.invalidResponse
            }
            
            request.setValue(
                "Bearer \(token)",
                forHTTPHeaderField: "Authorization"
            )
            
            return token
        }
    }
    
    private func refreshAccessToken() async throws -> String {
        let response: SuccessResponseModel<RefreshTokenResponseModel> = try await post(
            SuccessResponseModel<RefreshTokenResponseModel>.self,
            to: refreshUrl,
            auth: .none
        )
        
        guard let accessToken = response.data?.accessToken else {
            throw ApiError.invalidResponse
        }
        
        return accessToken
    }
    
}
