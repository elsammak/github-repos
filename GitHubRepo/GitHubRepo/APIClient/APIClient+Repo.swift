//
//  APIClient+Repo.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/21.
//

import Foundation
extension APIClient {
    
    /**
     Fetch list of repo for user
     - Returns: RepoJson object or throws an error if failed.
     */
    func getRepoList(fromUrl nextUserUrl: String? = nil, ofUser userLogin: String) async -> (Result<([RepoJSON], String?), ChatError>) {
        
        // Create url request
        
        var urlString: String!
        if let urlStoredValue = nextUserUrl {
            urlString = urlStoredValue
        } else {
            urlString = baseURL + "/users/\(userLogin)/repos"
        }
        
        guard let url = URL(string: urlString) else {
            var chatError = ChatError()
            chatError.errorMessage = "INVALID_URL"
            return .failure(chatError)
        }
        
        var request = URLRequest(url: url)
        
        
        if let githubToken = ProcessInfo.processInfo.environment["access_token"] {
            request.setValue("token \(githubToken)", forHTTPHeaderField: "Authorization")
        } else {
            var chatError = ChatError()
            chatError.errorMessage = "No GitHub token found"
            return .failure(chatError)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                var chatError = ChatError()
                chatError.errorMessage = "Invalid response"
                return .failure(chatError)
            }
            
            
            let decoder = JSONDecoder()
            let reposArray = try decoder.decode([RepoJSON].self, from: data)
            
            var nextUrl: String?
            if let httpResponse = response as? HTTPURLResponse, let str = httpResponse.allHeaderFields["Link"] as? String {
                nextUrl = extractNextUrl(fromString: str)
            }
            
            return .success((reposArray, nextUrl))
        } catch {
            var chatError = ChatError()
            chatError.errorMessage = "USERS_PARSING_ERROR"
            return .failure(chatError)
        }
    }
}
