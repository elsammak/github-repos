//
//  AppError.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

/// Main error object used for this app, all errors form server or code should be mapped to this error.
import Foundation
enum AppError: LocalizedError {
    case noInternet
    case invalidURL
    case invalidToken
    case invalidResponse
    case serverUnreachable(String)
    case unknownError(String)
    
    var errorDescription: String? {
        switch self {
            
        case .noInternet:
            return UILabelString.noconnectionTitle
        case .serverUnreachable(let message):
            return message
        case .invalidURL:
            return UILabelString.invalidURLTitle
        case .invalidToken:
            return UILabelString.invalidTokenTitle
        case .invalidResponse:
            return UILabelString.invalidResponseTitle
        case .unknownError(let message):
            return message
        }
    }
}

extension AppError: Equatable {}
