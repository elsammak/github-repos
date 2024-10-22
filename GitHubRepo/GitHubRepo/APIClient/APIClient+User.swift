//
//  APIClient+User.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

import Foundation
extension APIClient {

    /**
     Fetch list of users. If nextUserUrl is nil, it starts with the first page of users.
     With every response the next request url is included inside the header and should be used for the next request.
     - Returns: UserJson object and next request URL if succeeded, or throws an error if failed.
     */
    func getUsers(fromUrl nextUserUrl: String? = nil) async -> (Result<([UserJSON], String?), AppError>) {
        
            // Create url request
        var urlString: String!
        if let urlStoredValue = nextUserUrl {
            urlString = urlStoredValue
        } else {
            urlString = baseURL + "/users?"
        }

        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }

        var request = URLRequest(url: url)
        request.cachePolicy = APIEndPoint.cachePolicy
            
        if let githubToken = getAccessToken() {
            request.setValue("token \(githubToken)", forHTTPHeaderField: "Authorization")
        } else {
            return .failure(.invalidToken)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let _ = response as? HTTPURLResponse else {      
                return .failure(.invalidResponse)
            }
            

            let decoder = JSONDecoder()
            let usersArray = try decoder.decode([UserJSON].self, from: data)
            
            var nextUrl: String?
            if let httpResponse = response as? HTTPURLResponse, let str = httpResponse.allHeaderFields["Link"] as? String {
                nextUrl = extractNextUrl(fromString: str)
            }

            return .success((usersArray, nextUrl))
        } catch (let error) {
            return .failure(.unknownError(error.localizedDescription))
        }
    }
    

    /**
     Get next request URL from the response header.
     
     - parameter string: `Link` field in the response header.
     
     - Returns: Next request url string if available, else nil.
     */
    func extractNextUrl(fromString string: String) -> String? {
        let array = string.components(separatedBy: ",")
        for element in array {
            let part = element.components(separatedBy: ";")
            if part[1].trimmingCharacters(in: .whitespacesAndNewlines) == "rel=\"next\"" {
                let nextUrl = part[0]
                if let start = nextUrl.firstIndex(of: "<"), let end = nextUrl.firstIndex(of: ">") {
                    let startIndex = nextUrl.index(after: start) // Move the index after "<"
                    let endIndex = nextUrl.index(after: end) // Move the index before ">"
                    return String(nextUrl[startIndex..<endIndex]) // Return the substring between "<" and ">"
                }

            }
        }
        return nil
    }
    
    func getUserDetails(ofUser user: UserJSON) async -> (Result<UserJSON, AppError>) {
        
        let urlString = baseURL + "/users/\(user.login)"
        
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }

        var request = URLRequest(url: url)
        request.cachePolicy = APIEndPoint.cachePolicy

        if let githubToken = getAccessToken() {
            request.setValue("token \(githubToken)", forHTTPHeaderField: "Authorization")
        } else {
            return .failure(.invalidToken)
        }
        
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let _ = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }
            

            let decoder = JSONDecoder()
            let updatedUser = try decoder.decode(UserJSON.self, from: data)


            return .success(updatedUser)
        } catch (let error) {
            return .failure(.unknownError(error.localizedDescription))
        }
        
    }
}
