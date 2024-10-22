//
//  Globals.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

/// API server configurations

import Foundation
struct APIEndPoint {
    static let hostUrl = "https://api.github.com"
    static let cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData
}

// Localization is not implemented, but I added all UI text in a struct here.
// The quality of the product should be a Production quality, having this struct will make it easy to add localization feature in the future
struct UILabelString {
    
    // Screens title
    static let userNameTitle: String = "Username"
    static let starsTitle: String = "Stars"
    static let fullNameTitle: String = "Full Name"
    static let followersTitle: String = "Followers"
    static let followingTitle: String = "Following"
    static let reposListTitle: String = "List of Repositories"
    static let displayedReposCount: String = "Currently displayed repositories:"
    
    
    // Errors titles
    static let cancelTitle: String = "Cancel"
    static let errorTitle: String = "Error"
    static let noconnectionTitle: String = "No Internet Connection!"
    static let invalidURLTitle: String = "Invalid URL!"
    static let invalidTokenTitle: String = "Invalid Token!"
    static let invalidResponseTitle: String = "Invalid Response!"  
    static let defaultErrorMessage: String = "Unknown Error!"
    
}
