//
//  MovieCellViewModel.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 6.12.2024.
//

import Foundation

struct MovieCellViewModel {
    let title: String
    let details: String // Film detayı (ör. yıl ve puan bilgisi)
    let posterURL: URL? // Poster URL'si
    
    // Init ile veriyi düzenle
    init(movie: Movie) {
        self.title = movie.title
        self.details = "\(movie.releaseDate) | Rating: \(movie.voteAverage)" // Detay birleştirme
        self.posterURL = URL(string: movie.posterPath)
    }
}
