//
//  RepositoriesViewModel.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/21.
//

import Foundation

final class RepositoriesViewModel: AbstractViewModel {
    
    // Vars
    
    @Published var user: UserJSON!
    @Published var reposArray: [RepoJSON] = []
     

    // MARK:- Remote APIs
    @MainActor
    func loadRepos(forUser login: String) async {
                
        guard !isLoading else { return } // Prevent multiple API calls
        
        isLoading = true
        error = nil
        
        let result = await apiClient.getRepoList(ofUser: login)
        
        switch result {
        case .success(let reposArray):
            self.reposArray = reposArray            
            
        case .failure(let chatError):
            error = chatError
        }
        
        isLoading = false // Reset loading state

    }
}
