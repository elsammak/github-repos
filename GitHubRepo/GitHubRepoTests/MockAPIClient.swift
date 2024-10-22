//
//  MockAPIClient.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/21.
//


@testable import GitHubRepo
class MockAPIClient: APIClientProtocol {
    
    var usersResult: Result<([UserJSON], String?), AppError>?
    var userDetailsResult: Result<UserJSON, AppError>?
    var repoResult: Result<([RepoJSON], String?), AppError>?
    var nextUserUrl: String?
    
    func getUserDetails(ofUser user: UserJSON) async -> (Result<UserJSON, AppError>) {
        
        return userDetailsResult ?? .failure(.unknownError("No result provided"))
    }
    
    func getRepoList(fromUrl nextUserUrl: String?, ofUser userLogin: String) async -> (Result<([RepoJSON], String?), AppError>) {
        
        return repoResult ?? .failure(.unknownError("No result provided"))
    }
    
    
    func getUsers(fromUrl nextUserUrl: String?) async -> Result<([UserJSON], String?), AppError> {
        return usersResult ?? .failure(.unknownError("No result provided"))
    }
    
}
