//
//  Actor.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 1.03.2025.
//

import Foundation

struct Actor: Codable {
    let id: Int
    let name: String
    let profilePath: String?
    let biography: String?
    let knownForDepartment: String?
    let popularity: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case biography
        case knownForDepartment = "known_for_department"
        case popularity
    }
}

struct ActorResponse: Codable {
    let results: [Actor]
}
