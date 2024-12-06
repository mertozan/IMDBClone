//
//  MovieDetailsViewModel.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 6.12.2024.
//

import Foundation

class MovieDetailViewModel {
    private let movie: Movie
    private(set) var recommendations: [Movie] = [] // Önerilen filmler
    
    // Init ile bir Movie nesnesi alıyoruz
    init(movie: Movie) {
        self.movie = movie
    }
    
    // Önerilen filmleri API’den çekme
    func fetchRecommendations(completion: @escaping () -> Void) {
        APIService.shared.fetchRecommendedMovies(for: movie.id) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.recommendations = movies
                completion()
            case .failure(let error):
                print("Error fetching recommendations: \(error.localizedDescription)")
            }
        }
    }
    
    // View'da gösterilecek veriler
    var title: String {
        return movie.title
    }
    
    var overview: String {
        return movie.overview
    }
    
    var releaseDate: String {
        return "Release Date: \(movie.releaseDate)"
    }
    
    var rating: String {
        return "Rating: \(movie.voteAverage)"
    }
    
    var genres: String {
        let genreNames = movie.genreIDs.compactMap { genreDictionary[$0] }
        return "Genres: \(genreNames.joined(separator: ", "))"
    }
    
    var posterURL: URL? {
        if let posterPath = movie.posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        }
        return nil // Poster yoksa nil döner
    }
}
