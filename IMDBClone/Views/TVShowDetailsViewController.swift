//
//  TVShowDetailsViewController.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 1.03.2025.
//

import UIKit
import YouTubeiOSPlayerHelper

class TVShowDetailsViewController: UIViewController {
    var viewModel: TVShowDetailsViewModel!
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var recommendationCollectionView: UICollectionView!
    @IBOutlet var trailerView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = viewModel.title
        // Diğer UI elemanlarını ayarla
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
