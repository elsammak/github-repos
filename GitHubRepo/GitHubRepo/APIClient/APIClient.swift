//
//  APIClient.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

import Foundation

class APIClient {
    
    var baseURL: String = ""
    let session: URLSession!
    
    init() {
        baseURL = APIEndPoint.hostUrl
        session = URLSession.shared
    }
}
