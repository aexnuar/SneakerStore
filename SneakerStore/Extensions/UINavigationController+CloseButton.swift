//
//  UINavigationController+CloseButton.swift
//  SneakerStore
//
//  Created by aex on 13.09.2025.
//

import UIKit

extension UINavigationController {
    func setupNavBarWithCloseButton(
        target: Any?,
        action: Selector,
        tintColor: UIColor = .label,
        pointSize: CGFloat = 14,
        weight: UIImage.SymbolWeight = .regular,
        imageName: String = "xmark"
    ) {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight)
        let image = UIImage(systemName: imageName, withConfiguration: imageConfig)
        
        let closeButton = UIBarButtonItem(
            image: image,
            style: .plain,
            target: target,
            action: action
        )
        
        closeButton.tintColor = tintColor
        topViewController?.navigationItem.leftBarButtonItem = closeButton
        
        let appearance = UINavigationBarAppearance() /// скрываем серый в нав баре при скролле тейбл вью снизу вверх
        appearance.configureWithTransparentBackground()
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
