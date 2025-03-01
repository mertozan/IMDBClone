//
//  APIService.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 3.12.2024.
//

import Foundation

let genreDictionary: [Int: String] = [
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
    37: "Western"
]

class APIService {
    static let shared = APIService()
    
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "3d63aa5cd7c3e5b39a804e3db145daf5"
    
    /// Popüler filmleri getirir
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "\(baseURL)/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        performRequest(url: url) { (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let movieResponse):
                completion(.success(movieResponse.results)) // `results` dizisini döndür
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieDetails(for movieID: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        let urlString = "\(baseURL)/movie/\(movieID)?api_key=\(apiKey)&language=en-US"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        performRequest(url: url) { (result: Result<Movie, Error>) in
            switch result {
            case .success(let movie):
                print("Movie Details - Runtime: \(String(describing: movie.runtime))")
                completion(.success(movie))
            case .failure(let error):
                print("Error fetching movie details: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    /// Belirli bir film için önerilen filmleri getirir
    func fetchRecommendedMovies(for movieID: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "\(baseURL)/movie/\(movieID)/recommendations?api_key=\(apiKey)&language=en-US&page=1"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        // Beklenen türü `MovieResponse` olarak belirtin
        performRequest(url: url) { (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let movieResponse):
                completion(.success(movieResponse.results)) // `results` içindeki filmleri döndür
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "\(baseURL)/search/movie?api_key=\(apiKey)&language=en-US&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&page=1&include_adult=false"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        performRequest(url: url) { (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let movieResponse):
                completion(.success(movieResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieTrailer(for movieID: Int, completion: @escaping (Result<VideoResponse, Error>) -> Void) {
        let urlString = "\(baseURL)/movie/\(movieID)/videos?api_key=\(apiKey)&language=en-US"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        performRequest(url: url) { (result: Result<VideoResponse, Error>) in
            completion(result)
        }
    }
    
    /// Genel bir API isteği gerçekleştiren yardımcı fonksiyon
    private func performRequest<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                return
            }
            
            // API yanıtını kontrol edelim
            if let jsonString = String(data: data, encoding: .utf8) {
                print("API Response: \(jsonString)")
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                print("Decode error: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // Popüler dizileri getir
    func fetchPopularTVShows(completion: @escaping (Result<[TVShow], Error>) -> Void) {
        let urlString = "\(baseURL)/tv/popular?api_key=\(apiKey)&language=en-US&page=1"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        performRequest(url: url) { (result: Result<TVShowResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Popüler oyuncuları getir
    func fetchPopularActors(completion: @escaping (Result<[Actor], Error>) -> Void) {
        let urlString = "\(baseURL)/person/popular?api_key=\(apiKey)&language=en-US&page=1"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        performRequest(url: url) { (result: Result<ActorResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Film veya dizi oyuncu kadrosunu getir
    func fetchCast(for id: Int, isMovie: Bool, completion: @escaping (Result<[Cast], Error>) -> Void) {
        let mediaType = isMovie ? "movie" : "tv"
        let urlString = "\(baseURL)/\(mediaType)/\(id)/credits?api_key=\(apiKey)&language=en-US"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        performRequest(url: url) { (result: Result<CastResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.cast))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct VideoResponse: Codable {
    let results: [Video]
}

struct Video: Codable {
    let key: String
    let site: String
    let type: String
    let name: String
}
