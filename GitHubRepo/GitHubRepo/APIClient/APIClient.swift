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
    
    func getAccessToken() -> String? {
        /// Save token to keychain to access from device not xcode
        if let githubToken = ProcessInfo.processInfo.environment["access_token"] {
            saveToKeychain(token: githubToken)
            return githubToken
        } else if let githubToken = getTokenFromKeychain() {
            return githubToken
        } else {
            return nil
        }
    }
}
