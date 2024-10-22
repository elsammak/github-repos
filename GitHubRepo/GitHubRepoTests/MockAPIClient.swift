//
//  MockAPIClient.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/21.
//


@testable import GitHubRepo
class MockAPIClient: APIClientProtocol {
    
    var usersResult: Result<([UserJSON], String?), ChatError>?
    var userDetailsResult: Result<UserJSON, ChatError>?
    var repoResult: Result<([RepoJSON], String?), ChatError>?
    var nextUserUrl: String?
    
    func getUserDetails(ofUser user: UserJSON) async -> (Result<UserJSON, ChatError>) {
        
        return userDetailsResult ?? .failure(ChatError(errorMessage: "No result provided"))
    }
    
    func getRepoList(fromUrl nextUserUrl: String?, ofUser userLogin: String) async -> (Result<([RepoJSON], String?), GitHubRepo.ChatError>) {
        
        return repoResult ?? .failure(ChatError(errorMessage: "No result provided"))
    }
    
    
    func getUsers(fromUrl nextUserUrl: String?) async -> Result<([UserJSON], String?), ChatError> {
        return usersResult ?? .failure(ChatError(errorMessage: "No result provided"))
    }
    
}
