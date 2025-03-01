//
//  Cast.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 1.03.2025.
//

import Foundation

struct Cast: Codable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String?
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case profilePath = "profile_path"
        case order
    }
}

struct CastResponse: Codable {
    let cast: [Cast]
}
