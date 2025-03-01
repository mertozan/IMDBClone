//
//  TVShow.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 1.03.2025.
//

import Foundation

struct TVShow: Codable {
    let id: Int
    let name: String
    let overview: String
    let posterPath: String?
    let firstAirDate: String
    let voteAverage: Double
    let genreIDs: [Int]?
    var runtime: [Int]?  // Dizi bölüm süreleri array olarak geliyor
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case genreIDs = "genre_ids"
        case runtime = "episode_run_time"
    }
}

// API yanıtı için
struct TVShowResponse: Codable {
    let results: [TVShow]
}
