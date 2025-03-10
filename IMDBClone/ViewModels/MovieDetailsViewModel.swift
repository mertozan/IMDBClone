//
//  MovieDetailsViewModel.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 6.12.2024.
//

import Foundation

class MovieDetailViewModel {
    private var movie: Movie
    var recommendations: [Movie] = [] // Önerilen filmler
    
    private(set) var trailerKey: String?
    
    // Önerileri dışarıdan eklemek için bir yöntem
    func setRecommendations(_ movies: [Movie]) {
        self.recommendations = movies
    }
    
    // Init ile bir Movie nesnesi alıyoruz
    init(movie: Movie) {
        self.movie = movie
    }
    
    // Önerilen filmleri API'den çekme
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
    
    func fetchMovieDetails(completion: @escaping () -> Void) {
        APIService.shared.fetchMovieDetails(for: movie.id) { [weak self] result in
            switch result {
            case .success(let movieDetails):
                self?.movie = movieDetails // Gelen detaylı film bilgisiyle güncelleme
                completion()
            case .failure(let error):
                print("Error fetching movie details: \(error.localizedDescription)")
                completion()
            }
        }
    }
    
    func fetchTrailer(completion: @escaping () -> Void) {
        APIService.shared.fetchMovieTrailer(for: movie.id) { [weak self] result in
            switch result {
            case .success(let response):
                // YouTube trailer'ını bul
                if let trailer = response.results.first(where: { $0.site == "YouTube" && $0.type == "Trailer" }) {
                    self?.trailerKey = trailer.key
                    print("Found trailer key:", trailer.key)
                }
            case .failure(let error):
                print("Error fetching trailer:", error.localizedDescription)
            }
            completion()
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // API'den gelen tarih formatı
        guard let date = dateFormatter.date(from: movie.releaseDate) else {
            return movie.releaseDate // Eğer tarih formatı uymazsa orjinal değeri döner
        }
        
        dateFormatter.dateFormat = "yyyy" // Yıl formatına dönüştürür
        return dateFormatter.string(from: date)
    }
    
    var rating: String {
        return String (format: "%.1f", movie.voteAverage)
    }
    
    var genres: String {
        let genreNames = movie.genreIDs?.compactMap { genreDictionary[$0] }
        return "Genres: \(genreNames?.joined(separator: ", ") ?? "")"
    }
    
    var posterURL: URL? {
        if let posterPath = movie.posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        }
        return nil // Poster yoksa nil döner
    }
    
    var formattedDuration: String {
        guard let runtime = movie.runtime else { return "N/A" }
        
        let hours = runtime / 60
        let minutes = runtime % 60
        
        if hours > 0 {
            if minutes > 0 {
                return "\(hours)h \(minutes)m"  // Örnek: "2h 35m"
            } else {
                return "\(hours)h"  // Örnek: "2h"
            }
        } else {
            return "\(minutes)m"  // Örnek: "45m"
        }
    }
    
}
