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
        guard !favorites.contains(sneaker) else { return }
        favorites.append(sneaker)
        
        if let catalogueIndex = catalogue.firstIndex(of: sneaker) {
            catalogue[catalogueIndex].isFavorite = true
        }
    }
    
    func removeFromFavorites(_ sneaker: Sneaker) {
        guard let index = favorites.firstIndex(of: sneaker) else { return }
        favorites.remove(at: index)
        
        if let catalogueIndex = catalogue.firstIndex(of: sneaker) {
            catalogue[catalogueIndex].isFavorite = false
        }
        
//        guard var item = catalogue.first(where: { item in
//            item.brand == sneaker.brand
//        }) else { return }
//        
//        item.isFavorite = false
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
    
    func setCatalogue(catalogue: [Sneaker]) {
        self.catalogue = catalogue
    }
    
    func setFavorites(favorites: [Sneaker]) {
        self.favorites = favorites
    }
}

extension CatalogueDataManager {
    func updateSneaker(_ updatedSneaker: Sneaker) {
        if let index = catalogue.firstIndex(where: { $0.brand == updatedSneaker.brand && $0.sneaker == updatedSneaker.sneaker }) {
            catalogue[index] = updatedSneaker
        }
    }
    
    func indexOfSneaker(_ sneaker: Sneaker) -> Int? {
        catalogue.firstIndex(where: { $0.brand == sneaker.brand && $0.sneaker == sneaker.sneaker })
    }
}
