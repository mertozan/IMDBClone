//
//  SearchViewController.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 6.12.2024.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    var identifier = "SearchViewController"
    private var searchWorkItem: DispatchWorkItem?
    
    private var movies: [Movie] = []
    private var filteredMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchBar()
        title = "Search"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Search bar'ı aktif hale getir ve klavyeyi aç
        searchBar.becomeFirstResponder()
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        // TableView için hücre kaydı
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchCell")
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Search movies, TV shows, actors..."
        // Search bar'ın görünümünü özelleştir
        searchBar.searchBarStyle = .minimal
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        let movie = filteredMovies[indexPath.row]
        cell.textLabel?.text = movie.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Seçilen filmi detay sayfasına gönder
        let selectedMovie = filteredMovies[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
            detailVC.viewModel = MovieDetailViewModel(movie: selectedMovie)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchWorkItem?.cancel()
        
        guard !searchText.isEmpty else {
            filteredMovies = []
            tableView.reloadData()
            return
        }
        
        // Arama API çağrısı
        let workItem = DispatchWorkItem { [weak self] in
            APIService.shared.searchMovies(query: searchText) { [weak self] result in
                switch result {
                case .success(let movies):
                    self?.filteredMovies = movies
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error searching movies: \(error.localizedDescription)")
                }
            }
        }
        searchWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
