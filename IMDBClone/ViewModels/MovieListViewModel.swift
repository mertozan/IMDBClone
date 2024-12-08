//
//  MovieListViewModel.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 3.12.2024.
//

import Foundation

class MovieListViewModel {
    
    private(set) var movies: [Movie] = [] // API'den gelen tüm filmler
    private(set) var movieCellViewModels: [MovieCellViewModel] = [] // Hücreler için ViewModel'ler
    
    var onMoviesUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchMovies() {
        APIService.shared.fetchMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                self?.movieCellViewModels = movies.map {MovieCellViewModel(movie: $0)}
                self?.onMoviesUpdated?() // UI'yi günceller
            case .failure(let error):
                self?.onError?(error.localizedDescription) // Hata mesajını döndürür
            }
        }
    }
}
