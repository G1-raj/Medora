//
//  TokenManager.swift
//  Medora
//
//  Created by Govine Rajput on 20/11/26.
//

import Foundation

protocol TokenManagerProtocol: Sendable {
    
    func getAccessToken() async throws -> String?
    
    func saveAccessToken(_ token: String) async throws
    
    func clearAccessToken() async throws
    
    func refresh(
        using refreshClosure: @escaping @Sendable () async throws -> String
    ) async throws -> String
    
    func refreshIfNeeded(
        failedToken: String,
        using refreshClosure: @escaping @Sendable () async throws -> String
    ) async throws -> String
    
}

actor TokenManager: TokenManagerProtocol {
    private var accessToken: String?
    
    private var refreshTask: Task<String, Error>?
    private var refreshID: UUID?
    
    //fetch access token
    func getAccessToken() throws -> String? {
        if let accessToken, !accessToken.isEmpty {
            return accessToken
        }
        
        let storedToken = try KeyChainHelper.read()
        
        accessToken = storedToken
        
        return storedToken
    }
    
    //save access token
    func saveAccessToken(_ token: String) throws {
        try KeyChainHelper.save(token)
        
        accessToken = token
        
        refreshTask?.cancel()
        refreshTask = nil
        refreshID = nil
    }
    
    //delete access token
    func clearAccessToken() throws {
        accessToken = nil
        
        refreshTask?.cancel()
        refreshTask = nil
        refreshID = nil
        
        try KeyChainHelper.delete()
    }
    
    //refresh access token
    func refresh(
        using refreshClosure: @escaping @Sendable () async throws -> String
    ) async throws -> String {
        
        //Reuse existing refresh operation.
        if let refreshTask {
            return try await refreshTask.value
        }
        
        let id = UUID()
        
        refreshID = id
        
        let task = Task<String, Error> {
            try await performRefresh(
                id: id,
                using: refreshClosure
            )
        }
        
        refreshTask = task
        
        return try await task.value
    }
    
    //refresh if needed
    func refreshIfNeeded(
        failedToken: String,
        using refreshClosure: @escaping @Sendable () async throws -> String
    ) async throws -> String {
        
        // Another request might have already refreshed the token.
        if let currentToken = try getAccessToken(), currentToken != failedToken {
            return currentToken
        }
        
        return try await refresh(using: refreshClosure)
    }
    
    //perform refresh
    private func performRefresh(
        id: UUID,
        using refreshClosure: @escaping @Sendable () async throws -> String
    ) async throws -> String {
        do {
            
            let newToken = try await refreshClosure()
            
            // Prevent an outdated refresh from restoring a token
            // after logout or another token update.
            guard refreshID == id else {
                throw CancellationError()
            }
            
            // Persist the refreshed token.
            try KeyChainHelper.save(newToken)
            
            accessToken = newToken
            
            refreshTask = nil
            refreshID = nil
            
            return newToken
            
            
        } catch {
            if refreshID == id {
                refreshTask = nil
                refreshID = nil
            }
            
            throw error
        }
    }
 }
