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
    func getRepoList(ofUser userLogin: String) async -> (Result<[RepoJSON], ChatError>) {
        
        // Create url request
        var urlString = baseURL + "/users/\(userLogin)/repos"
        
        
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
            
            
            return .success(reposArray)
        } catch {
            var chatError = ChatError()
            chatError.errorMessage = "USERS_PARSING_ERROR"
            return .failure(chatError)
        }
    }
}
