//
//  ProfileViewController.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 8.12.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var totalListsLabel: UILabel!
    @IBOutlet var watchListCollectionView: UICollectionView!
    @IBOutlet var customListsTableView: UITableView!
    
    private let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupUI()
        setupCollectionView()
        setupTableView()
        print("Watchlist Count: \(viewModel.watchlist.count)")
        print("Custom Lists Count: \(viewModel.customLists.count)")
    }
    
    private func setupUI() {
        // Avatar Görseli
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.clipsToBounds = true
        avatarImageView.image = UIImage(named: "avatar_placeholder") // Placeholder görüntü
        
        // Kullanıcı Bilgileri
        userNameLabel.text = viewModel.userName
        totalListsLabel.text = "Total Lists: \(viewModel.totalLists)"
    }
    
    
    private func setupCollectionView() {
            // Delegate ve DataSource Ayarı
            watchListCollectionView.delegate = self
            watchListCollectionView.dataSource = self
            
            // Hücre Kayıt
            watchListCollectionView.register(UINib(nibName: "WatchListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WatchListCell")
            
            // Layout Özellikleri
            if let layout = watchListCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.minimumLineSpacing = 8
                layout.minimumInteritemSpacing = 8
            }
        }
    
    private func setupTableView() {
            // Delegate ve DataSource Ayarı
            customListsTableView.delegate = self
            customListsTableView.dataSource = self
            
            // Hücre Kayıt
            customListsTableView.register(UINib(nibName: "CustomListTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomListCell")
            
            // TableView Özelleştirme
            customListsTableView.backgroundColor = UIColor(named: "BackgroundColor")
            customListsTableView.separatorStyle = .none
        }
    
    
        private func setupBindings() {
            viewModel.onUserUpdated = { [weak self] in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    
                    // Kullanıcı Adı ve Avatar Güncellemesi
                    self.userNameLabel.text = self.viewModel.userName
                    if let url = URL(string: self.viewModel.avatarURL ?? "") {
                        self.avatarImageView.kf.setImage(with: url) // Kingfisher ile görsel yükleniyor
                    } else {
                        self.avatarImageView.image = UIImage(named: "avatar_placeholder")
                    }
                    
                    // Genel Bilgi Güncellemesi
                    self.totalListsLabel.text = "Total Lists: \(self.viewModel.totalLists)"
                    self.watchListCollectionView.reloadData()
                    self.customListsTableView.reloadData()
                }
            }
        }

        private func loadData() {
            viewModel.fetchProfileData()
        }
}


extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.watchlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchListCell", for: indexPath) as? WatchListCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = viewModel.watchlist[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 16 // 3 hücre yan yana
        return CGSize(width: width, height: width * 1.5) // 2:3 oranında boyut
    }
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.customLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomListCell", for: indexPath) as? CustomListTableViewCell else {
            return UITableViewCell()
        }
        let customList = viewModel.customLists[indexPath.row]
        cell.configure(with: customList)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 // Satır yüksekliği
    }
}


