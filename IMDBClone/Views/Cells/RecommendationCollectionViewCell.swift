//
//  RecommendationCollectionViewCell.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 6.12.2024.
//

import UIKit

class RecommendationCollectionViewCell: UICollectionViewCell {
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        
        if let posterPath = movie.posterPath, let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            posterImageView.kf.setImage(with: posterURL)
        } else {
            posterImageView.image = UIImage(named: "placeholder") // Poster yoksa yedek resim
        }
    }
    
}
