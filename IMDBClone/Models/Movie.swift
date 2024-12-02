//
//  Movie.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 3.12.2024.
//

import Foundation

struct Movie : Codable {
    let id: Int             // Filmin kimliği
    let title: String       // Filmin adı
    let overview: String    // Filmin açıklaması
    let posterPath: String  // Posterin URL yolu
    let releaseDate: String // Filmin çıkış tarihi
    
    // API'den gelen JSON anahtarları farklı olabilir, bu yüzden "CodingKeys" kullanıyoruz.
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path" // JSON'da 'poster_path' ismi kullanılıyor.
        case releaseDate = "release_date"   // JSON'da 'release_date' ismi kullanılıyor
    }
    
}
