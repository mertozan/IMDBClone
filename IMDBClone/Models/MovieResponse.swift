//
//  MovieResponse.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 3.12.2024.
//

import Foundation
// TMDB API'den dönen yanıtları temsil eder
struct MovieResponse: Codable {
    let results: [Movie]    // Film listesini temsil eder
}
