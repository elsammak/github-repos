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
    let followers: Int?
    let following: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case login, id, avatar_url, name, followers, following
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        login = try values.decodeIfPresent(String.self, forKey: .login)!
        id = try values.decodeIfPresent(Int.self, forKey: .id)!
        avatar_url = try values.decodeIfPresent(String.self, forKey: .avatar_url)!
        name = try values.decodeIfPresent(String.self, forKey: .name)
        followers = try values.decodeIfPresent(Int.self, forKey: .followers)
        following = try values.decodeIfPresent(Int.self, forKey: .following)
    }
    
    // Add an initializer for easy creation in previews
    init(login: String = "", avatar_url: String = "", id: Int = 0, name: String = "", followers: Int = 0, following: Int = 0) {
        self.login = login
        self.avatar_url = avatar_url
        self.id = id
        self.name = name
        self.followers = followers
        self.following = following        
    }
}
