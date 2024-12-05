//
//  ViewController.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 2.12.2024.
//

import UIKit

class MovieListViewController: UIViewController {
        
    @IBOutlet var tableView: UITableView!
    private let viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
        viewModel.fetchMovies()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 180
    }
    
    private func setupBindings() {
        viewModel.onMoviesUpdated = { [weak self] in
            DispatchQueue.main.async {
                    print("Filmler başarıyla yüklendi: \(self?.viewModel.movieCellViewModels.count ?? 0)")
                    self?.tableView.reloadData()
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

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.movieCellViewModels[indexPath.row]
        cell.configure(with: cellViewModel)
        return cell
    }
    
    
}

