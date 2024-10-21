//
//  UserJSON.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

import Foundation

struct UserJSON: Codable, Identifiable, Hashable {
    let login: String
    let avatar_url: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case login, id, avatar_url
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        login = try values.decodeIfPresent(String.self, forKey: .login)!
        id = try values.decodeIfPresent(Int.self, forKey: .id)!
        avatar_url = try values.decodeIfPresent(String.self, forKey: .avatar_url)!
    }
    
    // Add an initializer for easy creation in previews
    init(login: String, avatar_url: String, id: Int) {
        self.login = login
        self.avatar_url = avatar_url
        self.id = id
    }
}
