//
//  AbstractViewModel.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

/// Initialize necessary objects for all View Model instances.
import Foundation

class AbstractViewModel: ObservableObject {

    // Vars
    var apiClient: APIClientProtocol
    @Published var error: AppError?
    @Published var isLoading: Bool = false
            
    
    //MARK:- Inits
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
}
