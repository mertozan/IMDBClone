//
//  TVShowCollectionViewCell.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 1.03.2025.
//

import UIKit
import Kingfisher

class TVShowCollectionViewCell: UICollectionViewCell {
    static let identifier = "TVShowCell"
    
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
    
    func configure(with show: TVShow) {
        titleLabel.text = show.name
        if let posterPath = show.posterPath {
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            posterImageView.kf.setImage(with: imageUrl)
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "TVShowCollectionViewCell", bundle: nil)
    }
}
