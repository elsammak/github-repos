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
    func getRepoList(fromUrl nextUserUrl: String? = nil, ofUser userLogin: String) async -> (Result<([RepoJSON], String?), AppError>) {
        
        // Create url request
        
        var urlString: String!
        if let urlStoredValue = nextUserUrl {
            urlString = urlStoredValue
        } else {
            urlString = baseURL + "/users/\(userLogin)/repos?type=sources"
        }
        
        guard let url = URL(string: urlString) else {
            var appError = AppError()
            appError.errorMessage = "INVALID_URL"
            return .failure(appError)
        }
        
        var request = URLRequest(url: url)
        
        
        
        if let githubToken = getAccessToken() {
            request.setValue("token \(githubToken)", forHTTPHeaderField: "Authorization")
        } else {
            var appError = AppError()
            appError.errorMessage = "No GitHub token found"
            return .failure(appError)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let _ = response as? HTTPURLResponse else {
                var appError = AppError()
                appError.errorMessage = "Invalid response"
                return .failure(appError)
            }
            
            
            let decoder = JSONDecoder()
            let reposArray = try decoder.decode([RepoJSON].self, from: data)
            
            var nextUrl: String?
            if let httpResponse = response as? HTTPURLResponse, let str = httpResponse.allHeaderFields["Link"] as? String {
                nextUrl = extractNextUrl(fromString: str)
            }
            
            // Filter repositories to include only forks
            // According to the documentation, we should add type=sources to get non-forked repos. But as this is not working as
            // expected, I will filter here (ref: https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28)
            let forkedRepos = reposArray.filter { $0.fork }
            
            return .success((forkedRepos, nextUrl))
        } catch {
            var appError = AppError()
            appError.errorMessage = "USERS_PARSING_ERROR"
            return .failure(appError)
        }
    }
}
