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
    func getUsers(fromUrl nextUserUrl: String? = nil) async -> (Result<([UserJSON], String?), ChatError>) {
            // Create url request
            var urlString: String!
            if let urlStoredValue = nextUserUrl {
                urlString = urlStoredValue
            } else {
                urlString = baseURL + "/users?"
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
                let usersArray = try decoder.decode([UserJSON].self, from: data)
                
                var nextUrl: String?
                if let httpResponse = response as? HTTPURLResponse, let str = httpResponse.allHeaderFields["Link"] as? String {
                    nextUrl = extractNextUrl(fromString: str)
                }

                return .success((usersArray, nextUrl))
            } catch {
                var chatError = ChatError()
                chatError.errorMessage = "USERS_PARSING_ERROR"
                return .failure(chatError)
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
    
    func getUserDetails(ofUser user: UserJSON) async -> (Result<UserJSON, ChatError>) {
        
        let urlString = baseURL + "/users/\(user.login)"
        
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
            let updatedUser = try decoder.decode(UserJSON.self, from: data)


            return .success(updatedUser)
        } catch {
            var chatError = ChatError()
            chatError.errorMessage = "USERS_PARSING_ERROR"
            return .failure(chatError)
        }
        
    }
}
