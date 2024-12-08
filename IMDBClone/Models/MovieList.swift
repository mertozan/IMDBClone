//
//  MovieList.swift
//  IMDBClone
//
//  Created by Mert ÖZAN on 8.12.2024.
//
import Foundation

struct MovieList {
    let id: UUID
    let name: String
    var movies: [Movie] // Film modelini yeniden kullanıyoruz.
    let itemCount: Int // Bu alan tanımlanmış olmalı
}
