//
//  CustomListTableViewCell.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 8.12.2024.
//

import UIKit

class CustomListTableViewCell: UITableViewCell {

    @IBOutlet var listNameLabel: UILabel!
    @IBOutlet var itemCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with list: MovieList) {
            listNameLabel.text = list.name
            itemCountLabel.text = "\(list.movies.count) Movies"
        }
    
}
