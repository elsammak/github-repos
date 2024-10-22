//
//  Globals.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

/// API server configurations
struct APIEndPoint {
    static let hostUrl = "https://api.github.com"
}

/// As there is no Auth service, userId was added as a constant here.
struct UserInfo {
    static let userId: UInt64 = 0
}
