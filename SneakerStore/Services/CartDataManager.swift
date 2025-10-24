//
//  CartDataManager.swift
//  SneakerStore
//
//  Created by aex on 01.05.2025.
//

import Foundation
import UIKit

class CartDataManager {
    
    static let shared = CartDataManager()
    
    private var sneakers: [Sneaker] = []

    private init() {}
    
    func addToCart(_ sneaker: Sneaker) {
        sneakers.append(sneaker)
        
//        if let tabBarController = UIApplication.shared.windows.first?.rootViewController as? MainTabBarController {
//            tabBarController.updateCart()
//        }

    }
    
    func removeFromCart(at indexPath: IndexPath) {
        sneakers.remove(at: indexPath.row)
    }
    
    func getCartCount() -> Int {
        sneakers.count
    }
    
    func getSneaker(at indexPath: IndexPath) -> Sneaker {
        sneakers[indexPath.row]
    }
    
    func getTotalPrice() -> Int {
        var totalPrice = 0
        sneakers.forEach {
            let cleanPrice = $0.price.replacingOccurrences(of: " ", with: "")
            totalPrice += Int(cleanPrice) ?? 0
        }
        
        return totalPrice
    }
    
    func setSneakers(_ sneakers: [Sneaker]) {
        self.sneakers = sneakers
    }
}
