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
}
