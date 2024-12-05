//
//  ViewController.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 2.12.2024.
//

import UIKit

class MovieListViewController: UIViewController {
    
    private let viewModel = MovieListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.fetchMovies()
    }
    
    private func setupBindings() {
            viewModel.onMoviesUpdated = { [weak self] in
                DispatchQueue.main.async {
                    // Filmler başarıyla alındı, TableView'i güncelleyin
                    print("Filmler başarıyla güncellendi: \(self?.viewModel.movies.count ?? 0) adet film.")
                }
            }
            
            viewModel.onError = { (error: String) in
                DispatchQueue.main.async {
                    // Bir hata oluştuğunda kullanıcıya göster
                    print("Hata: \(error)")
                }
            }
        }

}

