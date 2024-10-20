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
    var apiClient: APIClient!
    @Published var error: ChatError?
    @Published var isLoading: Bool = false
    
    //MARK:- Inits
    init() {
        apiClient = APIClient()
    }
}
