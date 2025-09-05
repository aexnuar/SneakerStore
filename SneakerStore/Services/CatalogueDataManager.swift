//
//  CatalogueDataManager.swift
//  SneakerStore
//
//  Created by aex on 06.05.2025.
//

import Foundation

class CatalogueDataManager {
    
    static let shared = CatalogueDataManager()
    
    private var catalogue: [Sneaker] = []
    private var favorites: [Sneaker] = []
    
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
    
    func getSneaker(at indexPath: IndexPath) -> Sneaker {
        catalogue[indexPath.item]
    }
    
    func getFavoriteSneaker(at indexPath: IndexPath) -> Sneaker {
        favorites[indexPath.item]
    }
    
    func getCatalogue(catalogue: [Sneaker]) {
        self.catalogue = catalogue
    }
}
