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
        
        
        
        performRequest(url: url) { (result: Result<Movie, Error>) in
            switch result {
            case .success(let movie):
                print("Movie Details: \(movie)")
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
                if httpResponse.statusCode != 200 {
                    completion(.failure(NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)))
                    return
                }
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("API Response JSON: \(jsonString)")
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                print("JSON Decode Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
