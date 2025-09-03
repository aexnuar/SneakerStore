//
//  CatalogueDataManager.swift
//  SneakerStore
//
//  Created by aex on 06.05.2025.
//

import Foundation

class CatalogueDataManager {
    
    static let shared = CatalogueDataManager()
    
    var catalogue: [Sneaker] = []
    var favorites: [Sneaker] = []
    
    private init() {}
    
    func addToFavorites(sneaker: Sneaker) {
        favorites.append(sneaker)
    }
    
    func removeFromFavorites(sneaker: Sneaker) {
        guard let index = favorites.firstIndex(of: sneaker) else { return }
        favorites.remove(at: index)
        
        guard var item = catalogue.first(where: { item in
            item.brand == sneaker.brand
        }) else { return }
        
        item.isFavorite = false
    }
    
    func getCatalogueCount() -> Int {
        catalogue.count
    }
    
    func getFavoritesCount() -> Int {
        favorites.count
    }
    
    func getFavoriteSneaker(at indexPath: IndexPath) -> Sneaker {
        favorites[indexPath.item]
    }
}
