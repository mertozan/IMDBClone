//
//  HomeViewModel.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 1.03.2025.
//

import Foundation
import Dispatch

class HomeViewModel {
    // MARK: - Properties
    private(set) var popularMovies: [Movie] = []
    private(set) var popularTVShows: [TVShow] = []
    private(set) var popularActors: [Actor] = []
    
    // MARK: - Data Fetching Methods
    func fetchAllData(completion: @escaping () -> Void) {
        let group = DispatchGroup()
        
        // Popüler filmleri getir
        group.enter()
        fetchPopularMovies {
            group.leave()
        }
        
        // Popüler dizileri getir
        group.enter()
        fetchPopularTVShows {
            group.leave()
        }
        
        // Popüler oyuncuları getir
        group.enter()
        fetchPopularActors {
            group.leave()
        }
        
        // Tüm veriler geldiğinde completion çağır
        group.notify(queue: DispatchQueue.main) {
            completion()
        }
    }
    
    private func fetchPopularMovies(completion: @escaping () -> Void) {
        APIService.shared.fetchMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.popularMovies = movies
            case .failure(let error):
                print("Error fetching popular movies:", error)
            }
            completion()
        }
    }
    
    private func fetchPopularTVShows(completion: @escaping () -> Void) {
        APIService.shared.fetchPopularTVShows { [weak self] result in
            switch result {
            case .success(let shows):
                self?.popularTVShows = shows
            case .failure(let error):
                print("Error fetching popular TV shows:", error)
            }
            completion()
        }
    }
    
    private func fetchPopularActors(completion: @escaping () -> Void) {
        APIService.shared.fetchPopularActors { [weak self] result in
            switch result {
            case .success(let actors):
                self?.popularActors = actors
            case .failure(let error):
                print("Error fetching popular actors:", error)
            }
            completion()
        }
    }
}

