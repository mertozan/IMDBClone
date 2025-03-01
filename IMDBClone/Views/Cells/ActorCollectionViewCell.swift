//
//  ActorCollectionViewCell.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 1.03.2025.
//

import UIKit
import Kingfisher

class ActorCollectionViewCell: UICollectionViewCell {
    static let identifier = "ActorCell"
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        profileImageView.layer.cornerRadius = 15
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.numberOfLines = 2
    }
    
    func configure(with actor: Actor) {
        titleLabel.text = actor.name
        if let profilePath = actor.profilePath {
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")
            profileImageView.kf.setImage(with: imageUrl)
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ActorCollectionViewCell", bundle: nil)
    }
}
