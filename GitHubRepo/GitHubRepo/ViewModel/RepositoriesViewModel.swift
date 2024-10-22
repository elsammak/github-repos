//
//  RepositoriesViewModel.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/21.
//

import Foundation

final class RepositoriesViewModel: AbstractViewModel {
    
    // Vars
    var nextUserUrl: String?
    @Published var user: UserJSON!
    @Published var reposArray: [RepoJSON] = []
     

    // MARK:- Remote APIs
    @MainActor
    func loadRepos(forUser login: String) async {
                
        guard !isLoading else { return } // Prevent multiple API calls
        
        isLoading = true
        error = nil
        
        let result = await apiClient.getRepoList(fromUrl: nextUserUrl, ofUser: login)
        
        switch result {
        case .success(let (reposArray, nextUrl)):
            self.reposArray.append(contentsOf: reposArray) // Append new repos to the list
            
            // Handle pagination
            self.nextUserUrl = nextUrl
            
        case .failure(let appError):
            error = appError
        }
        
        isLoading = false // Reset loading state

    }
}
