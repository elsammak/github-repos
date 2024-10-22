//
//  APIClient.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

import Foundation

class APIClient: APIClientProtocol {
    
    var baseURL: String = ""
    let session: URLSession!
    static let shared = APIClient() // Shared instance
    
    init() {
        baseURL = APIEndPoint.hostUrl
        session = URLSession.shared
    }

    /// Save token to keychain to access from device not xcode
    /// This is better to be handled via CI/CD, but it needs to have an app provision certificates to I used Environment instead
    func getAccessToken() -> String? {
        if let githubToken = ProcessInfo.processInfo.environment["access_token"] {
            saveToKeychain(token: githubToken)
            return githubToken
        } else if let githubToken = getTokenFromKeychain() {
            return githubToken
        } else {
            return nil
        }
    }
    
    
    // Convert the network error to an AppError
    func handleNetworkError(_ error: Error) -> AppError {
        
        // Check if the error is an Apollo URLSessionClient error
//        if let apolloError = error as? Apollo.URLSessionClient.URLSessionClientError {
//            return .serverUnreachable(apolloError.localizedDescription) // Apollo wraps mamy types of errors, we can do mapping later here
//        } else if (error as NSError).domain == NSURLErrorDomain {
//            return .noInternet
//        }
            // Fallback for other types of errors
           return .unknownError(error.localizedDescription)
    }
}
