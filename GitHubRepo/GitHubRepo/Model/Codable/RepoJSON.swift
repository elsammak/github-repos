//
//  RepoJSON.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/21.
//


import Foundation

struct RepoJSON: Codable, Identifiable, Hashable {
    
    var id: Int
    let name: String
    let language: String?
    let stargazers_count: Int
    let description: String?
    let fork: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name, language, stargazers_count, description, fork
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)!
        name = try values.decodeIfPresent(String.self, forKey: .name)!
        language = try values.decodeIfPresent(String.self, forKey: .language)
        stargazers_count = try values.decodeIfPresent(Int.self, forKey: .stargazers_count)!
        description = try values.decodeIfPresent(String.self, forKey: .description)
        fork = try values.decodeIfPresent(Bool.self, forKey: .fork)!
    }
    
    // Add an initializer for easy creation in previews
    init(id: Int, name: String, language: String, stargazers_count: Int, description: String?, fork: Bool = false) {
        self.id = id
        self.name = name
        self.language = language
        self.stargazers_count = stargazers_count
        self.description = description
        self.fork = fork
    }
}
