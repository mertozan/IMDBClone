//
//  TVShowDetailsViewModel.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 1.03.2025.
//

class TVShowDetailsViewModel {
    private let tvShow: TVShow
    
    init(tvShow: TVShow) {
        self.tvShow = tvShow
    }
    
    var title: String {
        return tvShow.name
    }
    
    var overview: String {
        return tvShow.overview
    }
    
    var posterPath: String? {
        return tvShow.posterPath
    }
}



