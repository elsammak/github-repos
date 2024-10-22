//
//  UsersViewModel.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

/// The ViewModel to deal with User module. It acts as middle layer between User UI layer and User model layer.
import Foundation

final class UsersViewModel: AbstractViewModel {
    
    // Vars
    var nextUserUrl: String?
    @Published var users: [UserJSON] = []
    
    // MARK:- Remote APIs
    @MainActor
    func loadUsers() async {

        guard !isLoading else { return } // Prevent multiple API calls
        
        isLoading = true
        error = nil
        
        let result = await apiClient.getUsers(fromUrl: nextUserUrl)
                
        switch result {
        case .success(let (usersArray, nextUrl)):
            self.users.append(contentsOf: usersArray) // Append new users to the list
            
            // Handle pagination
            self.nextUserUrl = nextUrl
            
        case .failure(let chatError):            
            error = chatError
        }
        
        isLoading = false // Reset loading state

    }
    
    @MainActor
    func getUserDetails(for user: UserJSON) async {
        
        guard !isLoading else { return } // Prevent multiple API calls
        
        isLoading = true
        error = nil
        
        let result = await apiClient.getUserDetails(ofUser: user)
        
        switch result {
        case .success(let userDetails):
            if let index = users.firstIndex(where: { $0.id == userDetails.id }) {
                users[index] = userDetails
            }
        case .failure(let chatError):
            error = chatError
        }
        
        isLoading = false // Reset loading state
        
    }
}
