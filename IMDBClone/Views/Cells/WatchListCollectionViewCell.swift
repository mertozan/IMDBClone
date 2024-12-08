//
//  WatchListCollectionViewCell.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 8.12.2024.
//

import UIKit

class WatchListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var posterImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with movie: Movie) {
        if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = UIImage(named: "placeholder") // Poster yoksa
        }
    }
    
}
