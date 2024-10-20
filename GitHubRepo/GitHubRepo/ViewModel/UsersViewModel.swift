//
//  UsersViewModel.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

/// The ViewModel to deal with User module. It acts as middle layer between User UI layer and User model layer.
import Foundation

class UsersViewModel: AbstractViewModel {
    
    // Vars
    var nextUserUrl: String = ""
    @Published var users: [UserJSON] = []
     
    //MARK:- Inits
    override init() {
        super.init()
    }

    // MARK:- Remote APIs
    @MainActor
    func loadUsers(nextUserUrl: String? = nil) async {
                
        guard !isLoading else { return } // Prevent multiple API calls
        
        isLoading = true
        error = nil
        
        let result = await apiClient.getUsers(fromUrl: nextUserUrl)
        
        switch result {
        case .success(let (usersArray, nextUrl)):
            self.users.append(contentsOf: usersArray) // Append new users to the list
            // Handle pagination
            if let nextUrl = nextUrl {
                await self.loadUsers(nextUserUrl: nextUrl)
            }
            
        case .failure(let chatError):
            error = chatError
        }
        
        isLoading = false // Reset loading state

    }

   
    
}
