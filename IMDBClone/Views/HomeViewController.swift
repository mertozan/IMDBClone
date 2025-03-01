//
//  HomeViewController.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 1.03.2025.
//

import UIKit
import Dispatch

class HomeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var populerMoviesCollectionView: UICollectionView!
    @IBOutlet var popularTVShowsCollectionView: UICollectionView!
    @IBOutlet var popularActorsCollectionView: UICollectionView!
    
    // MARK: - Properties
    private let viewModel = HomeViewModel()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        title = "Home"
        
        // Verileri yükle
        viewModel.fetchAllData { [weak self] in
            self?.reloadCollectionViews()
        }
    }
    
    // MARK: - Setup Methods
    private func setupCollectionViews() {
        // Collection View'ların delegate ve datasource'larını ayarla
        [populerMoviesCollectionView, popularTVShowsCollectionView, popularActorsCollectionView].forEach {
            $0?.delegate = self
            $0?.dataSource = self
        }
        
        // Cell'leri register et
        populerMoviesCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        popularTVShowsCollectionView.register(UINib(nibName: "TVShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TVShowCollectionViewCell.identifier)
        popularActorsCollectionView.register(UINib(nibName: "ActorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ActorCollectionViewCell.identifier)
        
        // Collection View Layout ayarları
        [populerMoviesCollectionView, popularTVShowsCollectionView, popularActorsCollectionView].forEach {
            if let layout = $0?.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
                layout.minimumInteritemSpacing = 8
                layout.minimumLineSpacing = 8
            }
        }
    }
    
    private func reloadCollectionViews() {
        populerMoviesCollectionView.reloadData()
        popularTVShowsCollectionView.reloadData()
        popularActorsCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case populerMoviesCollectionView:
            return viewModel.popularMovies.count
        case popularTVShowsCollectionView:
            return viewModel.popularTVShows.count
        case popularActorsCollectionView:
            return viewModel.popularActors.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case populerMoviesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
            let movie = viewModel.popularMovies[indexPath.item]
            cell.configure(with: movie)
            return cell
            
        case popularTVShowsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCollectionViewCell.identifier, for: indexPath) as! TVShowCollectionViewCell
            let show = viewModel.popularTVShows[indexPath.item]
            cell.configure(with: show)
            return cell
            
        case popularActorsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCollectionViewCell.identifier, for: indexPath) as! ActorCollectionViewCell
            let actor = viewModel.popularActors[indexPath.item]
            cell.configure(with: actor)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case populerMoviesCollectionView:
            let movie = viewModel.popularMovies[indexPath.item]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
                detailVC.viewModel = MovieDetailViewModel(movie: movie)
                navigationController?.pushViewController(detailVC, animated: true)
            }
            
        case popularTVShowsCollectionView:
            let show = viewModel.popularTVShows[indexPath.item]
            let detailVC = TVShowDetailsViewController()
            detailVC.viewModel = TVShowDetailsViewModel(tvShow: show)
            navigationController?.pushViewController(detailVC, animated: true)
            
        case popularActorsCollectionView:
            let actor = viewModel.popularActors[indexPath.item]
            let detailVC = ActorDetailsViewController()
            detailVC.viewModel = ActorDetailsViewModel(actor: actor)
            navigationController?.pushViewController(detailVC, animated: true)
            
        default:
            break
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 16
        return CGSize(width: width, height: width * 1.5)
    }
}
