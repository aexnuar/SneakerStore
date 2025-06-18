//
//  MainTabBarController.swift
//  SneakerStore
//
//  Created by Alex on 24.04.2025.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        
        UITabBar.appearance().tintColor = .label
    }
    
    private func setupViewControllers() {
        let catalogueVC = CatalogueViewController()
        let navCatalogueVC = UINavigationController(rootViewController: catalogueVC)
        navCatalogueVC.tabBarItem = UITabBarItem(title: "Каталог", image: UIImage(systemName: "bag"), tag: 0)
        
        let favoritesVC = FavoritesViewController()
        let navfavoritesVC = UINavigationController(rootViewController: favoritesVC)
        favoritesVC.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "heart"), tag: 1)
        
        let cartVC = CartViewController()
        cartVC.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart"), tag: 2)
        
        viewControllers = [navCatalogueVC, navfavoritesVC, cartVC]
        
        let catalogue = Sneaker.getCatalogue()
        CatalogueDataManager.shared.catalogue = catalogue
        
        print("cart VC from TabBar address: \(Unmanaged.passUnretained(cartVC).toOpaque())")
    }
}
