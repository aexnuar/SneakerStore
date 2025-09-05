//
//  File.swift
//  SneakerStore
//
//  Created by aex on 05.09.2025.
//

import Foundation

class DataFormatter {
    static let shared = DataFormatter()
    
    private init() {}
    
    func formatItemWord(for count: Int) -> String {
        let remainder10 = count % 10
        let remainder100 = count % 100
        
        if remainder10 == 1 && remainder100 != 11 {
            return "товар"
        } else if (2...4).contains(remainder10) && !(12...14).contains(remainder100) {
            return "товара"
        } else {
            return "товаров"
        }
    }
    
    func formatPrice(_ price: Int) -> String {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        
        return formatter.string(from: NSNumber(value: price)) ?? String(price)
    }
}
