//
//  CatalogueDataManager.swift
//  SneakerStore
//
//  Created by Alex on 06.05.2025.
//

import Foundation

class CatalogueDataManager {
    
    static let shared = CatalogueDataManager()
    
    /*private*/ var catalogue: [Sneaker] = []
    /*private*/ var favorites: [Sneaker] = []
    
    private init() {}
    
    func addToFavorites(sneaker: Sneaker) {
        favorites.append(sneaker)
        print(favorites)
    }
    
    func removeFromFavorites(sneaker: Sneaker) {
        guard let index = favorites.firstIndex(of: sneaker) else { return }
        favorites.remove(at: index)
        
        guard var item = catalogue.first(where: { item in
            item.brand == sneaker.brand
        }) else { return }
        
        item.isFavorite = false
    }
    
    func returnCatalogueCount() -> Int {
        catalogue.count
    }
}
