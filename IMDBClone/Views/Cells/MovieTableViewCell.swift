//
//  MovieTableViewCell.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 6.12.2024.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieDetailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(with viewModel: MovieCellViewModel) {
        movieTitleLabel.text = viewModel.title
        movieDetailsLabel.text = viewModel.details // Ek bilgiyi buraya atıyoruz.
        
        if let url = viewModel.posterURL {
            movieImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholder"),
                options: [
                .transition(.fade(0.3)),
                .cacheOriginalImage
            ]
            )
        } else {
            movieImageView.image = UIImage(named: "placeholder")
        }
    }
    
    

}
