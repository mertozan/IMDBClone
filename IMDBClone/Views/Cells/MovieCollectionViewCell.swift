//
//  MovieCollectionViewCell.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 1.03.2025.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieCell"
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
        posterImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.numberOfLines = 2
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        if let posterPath = movie.posterPath {
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            posterImageView.kf.setImage(with: imageUrl)
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MovieCollectionViewCell", bundle: nil)
    }
}
