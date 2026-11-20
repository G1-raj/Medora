//
//  ApiError.swift
//  Medora
//
//  Created by Govine Rajput on 20/11/26.
//

import Foundation

enum ApiError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case decodingError
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."

        case .invalidResponse:
            return "Invalid server response."

        case .serverError(let statusCode):
            return "Server returned error \(statusCode)."

        case .decodingError:
            return "Unable to process server response."

        case .networkError(let error):
            return error.localizedDescription
        }
    }
}
