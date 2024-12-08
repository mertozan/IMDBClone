//
//  UIView+Styling.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 8.12.2024.
//

import UIKit

extension UIView {
    /// Görünümü yuvarlak köşeler ve gölge ile özelleştirir.
    func applyRoundedCornersAndShadow(cornerRadius: CGFloat = 10, shadowColor: UIColor = .black, shadowOpacity: Float = 0.2, shadowOffset: CGSize = CGSize(width: 2, height: 2), shadowRadius: CGFloat = 4) {
        // Köşe yuvarlama
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        
        // Gölge
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }
}
