//
//  MovieDetailsViewController.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 6.12.2024.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movie: Movie?
    var viewModel: MovieDetailViewModel!
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var recommendationCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        
        
        viewModel.fetchRecommendations { [weak self] in
            DispatchQueue.main.async {
                self?.recommendationCollectionView.reloadData()
            }
        }
        
        guard let viewModel = viewModel else {
            fatalError("MovieDetailViewModel is not set")
        }
        
        titleLabel.text = viewModel.title
        ratingLabel.text = viewModel.rating
        releaseDateLabel.text = viewModel.releaseDate
        genresLabel.text = viewModel.genres
        overviewLabel.text = viewModel.overview
        
        if let url = viewModel.posterURL {
            posterImageView.kf.setImage(with: url)
        }
    }
}

// CollectionView Layout ve Boyutlandırma
extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 16 // 3 hücre yan yana
        return CGSize(width: width, height: width * 1.5) // 2:3 oranında boyut
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

// CollectionView DataSource ve Delegate
extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.recommendations.count // Önerilen filmlerin sayısı
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCell", for: indexPath) as? RecommendationCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let recommendation = viewModel.recommendations[indexPath.row]
        cell.configure(with: recommendation)
        return cell
    }
}
