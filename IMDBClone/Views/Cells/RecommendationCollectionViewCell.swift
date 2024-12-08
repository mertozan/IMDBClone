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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Hücreyi özelleştir
        contentView.applyRoundedCornersAndShadow()
        posterImageView.layer.cornerRadius = 10
        posterImageView.layer.masksToBounds = true
    }
    
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        
        // Poster görselini yükleme
        if let posterPath = movie.posterPath,
           let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            posterImageView.kf.setImage(with: posterURL)
        } else {
            posterImageView.image = UIImage(named: "placeholder") // Görsel yoksa yedek
        }
    }
    
}
