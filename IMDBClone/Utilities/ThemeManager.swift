//
//  ThemeManager.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 8.12.2024.
//

import UIKit

struct ThemeManager {
    static func applyTheme() {
        
        // UINavigationBar Tema Ayarları
        UINavigationBar.appearance().barTintColor = UIColor(hex: "#1C1C1E")
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(hex: "#F5F5F5"),
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        UINavigationBar.appearance().tintColor = UIColor(hex: "#E50914")
        
        // UITabBar Tema Ayarları
        UITabBar.appearance().isTranslucent = false // Tabbardaki rengi tam istediğimiz renk olarak kullanmamızı sağlıyor
        UITabBar.appearance().barTintColor = UIColor(hex: "#3c3f3c")
        UITabBar.appearance().tintColor = UIColor(hex: "#E50914")
        UITabBar.appearance().unselectedItemTintColor = UIColor(hex: "#CCCCCC")
        UITabBar.appearance().backgroundColor = UIColor(hex: "#3c3f3c")
        
        // UITableView Arka Planı
        
        UITableViewCell.appearance().backgroundColor = UIColor(hex: "#F5F5F5").withAlphaComponent(1.0)
        // UICollectionView Arka Planı
        //UICollectionView.appearance().backgroundColor = UIColor(hex: "#1C1C1E")
    }
}
