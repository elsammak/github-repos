//
//  UserJSON.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

import Foundation

struct UserJSON: Codable, Identifiable {
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
}
