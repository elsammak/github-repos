//
//  AppError.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

/// Main error object used for this app, all errors form server or code should be mapped to this error.
import Foundation
struct AppError: Error, Equatable {
    
    var errorCode: Int = 0
    var errorMessage: String!
    
    static func == (lhs: AppError, rhs: AppError) -> Bool {
        return lhs.errorCode == rhs.errorCode && lhs.errorMessage == rhs.errorMessage
    }
    
}
