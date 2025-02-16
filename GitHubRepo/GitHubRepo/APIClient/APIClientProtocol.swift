//
//  APIClientProtocol.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/21.
//

protocol APIClientProtocol {
    func getUsers(fromUrl nextUserUrl: String?) async -> Result<([UserJSON], String?), AppError>
    func getUserDetails(ofUser user: UserJSON) async -> (Result<UserJSON, AppError>)
    func getRepoList(fromUrl nextUserUrl: String?, ofUser userLogin: String) async -> (Result<([RepoJSON], String?), AppError>)
}
