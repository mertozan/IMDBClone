//
//  ProfileViewModel.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 8.12.2024.
//
import Foundation

class ProfileViewModel {
    private(set) var userName: String = "John Doe"
    private(set) var avatarURL: String? = nil // Avatar URL'si opsiyonel
    
    private(set) var watchlist: [Movie] = [] // Kullanıcının izleme listesi
    private(set) var customLists: [MovieList] = [] // Kullanıcının özel listeleri
    
    
    var onUserUpdated: (() -> Void)?
    var onWatchlistUpdated: (() -> Void)?
    var onCustomListsUpdated: (() -> Void)?
    var onError: ((String) -> Void)? // Hata callback
    
    
    var totalLists: Int {
        return customLists.count
    }
    
    func fetchProfileData() {
        // Örnek bir API çağrısı simülasyonu
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            // Örnek veriler
            self.userName = "Mert ÖZAN"
            self.avatarURL = "https://example.com/avatar.jpg"
            self.watchlist = [
                Movie(id: 1, title: "Inception", overview: "A mind-bending thriller", posterPath: nil, releaseDate: "2010-07-16", voteAverage: 8.8, genreIDs: [28, 878]),
                Movie(id: 2, title: "The Matrix", overview: "A hacker discovers reality is a simulation", posterPath: nil, releaseDate: "1999-03-31", voteAverage: 8.7, genreIDs: [28, 878])
            ]
            self.customLists = [
                MovieList(id: UUID(), name: "Favorites", movies: self.watchlist),
                MovieList(id: UUID(), name: "To Watch", movies: [])
            ]
            
            // Güncellemeyi tetikle
            DispatchQueue.main.async {
                self.onUserUpdated?()
            }
        }
    }
    
    
    
    func loadInitialData() {
        // Dummy Kullanıcı Bilgileri
        userName = "Mert ÖZAN"
        avatarURL = "https://i.pravatar.cc/150" // Örnek avatar resmi
        
        // Dummy Watchlist Verileri
        watchlist = [
            Movie(id: 1, title: "Interstellar", overview: "A journey beyond stars.", posterPath: nil, releaseDate: "2014-11-07", voteAverage: 8.6, genreIDs: [12, 878]),
            Movie(id: 2, title: "Inception", overview: "Dream within a dream.", posterPath: nil, releaseDate: "2010-07-16", voteAverage: 8.8, genreIDs: [28, 878])
        ]
        
        // Dummy Custom List Verileri
        customLists = [
            MovieList(id: UUID(), name: "Sci-Fi Favorites", movies: []),
            MovieList(id: UUID(), name: "Oscar Winners", movies: [])
        ]
        
        // Callback'leri çağır
        onUserUpdated?()
        onWatchlistUpdated?()
        onCustomListsUpdated?()
    }
    
    
    func addToWatchlist(movie: Movie) {
        guard !watchlist.contains(where: { $0.id == movie.id }) else {
            onError?("Bu film zaten izleme listenizde!")
            return
        }
        watchlist.append(movie)
        onWatchlistUpdated?()
    }
    
    func removeFromWatchlist(movieID: Int) {
        watchlist.removeAll { $0.id == movieID }
        onWatchlistUpdated?()
    }
    
    
    func addMovieToCustomList(movie: Movie, listID: UUID) {
        guard let index = customLists.firstIndex(where: { $0.id == listID }) else {
            onError?("Liste bulunamadı!")
            return
        }
        customLists[index].movies.append(movie)
        onCustomListsUpdated?()
    }
}
