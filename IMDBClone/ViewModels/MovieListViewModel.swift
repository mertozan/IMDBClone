//
//  MovieListViewModel.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 3.12.2024.
//

import Foundation

class MovieListViewModel {
    
    var movies: [Movie] = []
    
    var onMoviesUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchMovies() {
        APIService.shared.fetchMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                self?.onMoviesUpdated?() // UI'yi günceller
            case .failure(let error):
                self?.onError?(error.localizedDescription) // Hata mesajını döndürür
            }
        }
    }
}
