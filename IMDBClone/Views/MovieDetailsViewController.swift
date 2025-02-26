//
//  MovieDetailsViewController.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 6.12.2024.
//

import UIKit
import YouTubeiOSPlayerHelper

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
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var trailerView: UIView! {
        didSet {
            setupYouTubePlayer()
        }
    }
    
    private var youtubePlayer: YTPlayerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //         Sağ üst köşeye 3 nokta ekleme
        //        navigationItem.rightBarButtonItem = UIBarButtonItem (
        //            image: UIImage(systemName: "ellipsis.circle"),
        //            style: .plain,
        //            target: self,
        //            action: #selector(didTapOptions)
        //        )
        
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        
        viewModel.fetchMovieDetails { [weak self] in
        DispatchQueue.main.async {
                self?.durationLabel.text = self?.viewModel.formattedDuration
            }
        }

        viewModel.fetchRecommendations { [weak self] in
            DispatchQueue.main.async {
                //                print("Yüklenen Filmler: \(self?.viewModel.recommendations)")
                self?.recommendationCollectionView.reloadData()
            }
        }
        
        viewModel.fetchTrailer { [weak self] in
            DispatchQueue.main.async {
                if let videoKey = self?.viewModel.trailerKey {
                    self?.youtubePlayer?.load(withVideoId: videoKey)
                }
            }
        }
        
        setupUI()
        
        guard let viewModel = viewModel else {
            fatalError("MovieDetailViewModel is not set")
        }
        
        titleLabel.text = viewModel.title
        ratingLabel.text = viewModel.rating
        releaseDateLabel.text = viewModel.releaseDate
        genresLabel.text = viewModel.genres
        overviewLabel.text = viewModel.overview
        durationLabel.text = viewModel.formattedDuration
        
        if let url = viewModel.posterURL {
            posterImageView.kf.setImage(with: url)
        }
        
    }
    
    private func setupUI() {
        // Label Özellikleri
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.preferredMaxLayoutWidth = 160
        titleLabel.text = "Movie Title" // Gelecek veriye göre değiştirilecek
        
        releaseDateLabel.font = UIFont.systemFont(ofSize: 14)
        releaseDateLabel.textColor = .gray
        releaseDateLabel.text = "2024"
        
        durationLabel.font = UIFont.systemFont(ofSize: 14)
        durationLabel.textColor = .gray
        durationLabel.text = "120 mins"
        
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 16)
        ratingLabel.textColor = .systemYellow
        ratingLabel.text = "8.5"
        
        // Poster ImageView Özellikleri
        posterImageView.layer.cornerRadius = 12
        posterImageView.clipsToBounds = true
        posterImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        posterImageView.image = UIImage(named: "placeholder") // Örnek görsel
        
        // Overview ve Genres Label
        overviewLabel.font = UIFont.systemFont(ofSize: 18)
        overviewLabel.numberOfLines = 9
        overviewLabel.text = "This is the movie overview. It provides a brief description about the movie."
        
        genresLabel.font = UIFont.systemFont(ofSize: 14)
        genresLabel.textColor = .gray
        genresLabel.text = "Genres: Action, Adventure"
        
        // Trailer View Özellikleri
        trailerView.backgroundColor = .black
        trailerView.layer.cornerRadius = 12
        trailerView.clipsToBounds = true
        trailerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]

        // Youtube Player'ın corner radius
        youtubePlayer?.layer.cornerRadius = 12
        youtubePlayer?.clipsToBounds = true
        youtubePlayer?.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        // Genel Arka Plan
        view.backgroundColor = .white
    }
    
    private func setupYouTubePlayer() {
        youtubePlayer = YTPlayerView()
        guard let youtubePlayer = youtubePlayer else { return }
        
        youtubePlayer.translatesAutoresizingMaskIntoConstraints = false
        trailerView.addSubview(youtubePlayer)
        
        NSLayoutConstraint.activate([
            youtubePlayer.topAnchor.constraint(equalTo: trailerView.topAnchor),
            youtubePlayer.leadingAnchor.constraint(equalTo: trailerView.leadingAnchor),
            youtubePlayer.trailingAnchor.constraint(equalTo: trailerView.trailingAnchor),
            youtubePlayer.bottomAnchor.constraint(equalTo: trailerView.bottomAnchor)
        ])
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = viewModel.recommendations[indexPath.row]
        
        // Detay sayfasına yönlendirme işlemini başlat
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
            detailVC.viewModel = MovieDetailViewModel(movie: selectedMovie)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
