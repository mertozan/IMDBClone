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
