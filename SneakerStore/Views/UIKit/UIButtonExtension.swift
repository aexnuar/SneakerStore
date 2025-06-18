//
//  UIButtonExtension.swift
//  SneakerStore
//
//  Created by Alex on 28.04.2025.
//

import UIKit

extension UIButton {
    convenience init(title: String? = nil) {
        self.init(type: .system)
        setTitle(title, for: .normal)
        layer.cornerRadius = 12
        tintColor = .white
        heightAnchor.constraint(equalToConstant: 46).isActive = true
        titleLabel?.font = .systemFont(ofSize: 14)
        backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    }
}
