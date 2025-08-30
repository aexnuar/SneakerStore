//
//  CartDataManager.swift
//  SneakerStore
//
//  Created by aex on 01.05.2025.
//

import Foundation

class CartDataManager {
    
    static let shared = CartDataManager()
    
    var sneakers: [Sneaker] = []
    
    private init() {}
    
    func addToCart(sneaker: Sneaker) {
        sneakers.append(sneaker)
    }
    
    func removeFromCart(at indexPath: IndexPath) {
        sneakers.remove(at: indexPath.row)
    }
    
    func returnCartCount() -> Int {
        sneakers.count
    }
}
