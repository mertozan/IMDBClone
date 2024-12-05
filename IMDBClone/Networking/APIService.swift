//
//  APIService.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 3.12.2024.
//

import Foundation

class APIService {
    static let shared = APIService()
            
        private let baseURL = "https://api.themoviedb.org/3"
        private let apiKey = "3d63aa5cd7c3e5b39a804e3db145daf5"
        
        func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
            let urlString = "\(baseURL)/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
            
            guard let url = URL(string: urlString) else {
                completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                    return
                }
                
                do {
                    let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(.success(movieResponse.results))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
}
