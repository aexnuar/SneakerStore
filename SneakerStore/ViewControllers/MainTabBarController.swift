//
//  MainTabBarController.swift
//  SneakerStore
//
//  Created by aex on 24.04.2025.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private var catalogue: [Sneaker]?
    
    var cartCount = 0 {
        didSet {
            if (oldValue == 0 && cartCount > 0) || (oldValue > 0 && cartCount == 0) {
                setupViewControllers()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData(from: Link.catalogue.rawValue)
        
        cartCount = CartDataManager.shared.getCartCount()
        
        UITabBar.appearance().tintColor = .label
    }
    
    // Метод для обновления cartCount и табов при изменении корзины
//        func updateCart() {
//            let newCount = CartDataManager.shared.getCartCount()
//            if newCount != cartCount {
//                cartCount = newCount
//            }
//        }
}

// MARK: - Private methods
extension MainTabBarController {
    private func setupViewControllers() {
        let catalogueVC = CatalogueViewController()
        let navCatalogueVC = UINavigationController(rootViewController: catalogueVC)
        navCatalogueVC.tabBarItem = UITabBarItem(title: "Каталог", image: UIImage(systemName: "bag"), tag: 0)
        
        let favoritesVC = FavoritesViewController()
        favoritesVC.favoritesDelegate = catalogueVC // подписка на делегат!
        let navfavoritesVC = UINavigationController(rootViewController: favoritesVC)
        favoritesVC.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "heart"), tag: 1)
        
        let cartVC = cartCount > 0 ? CartViewController() : EmptyCartViewController()
        cartVC.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart"), tag: 2)
        
        viewControllers = [navCatalogueVC, navfavoritesVC, cartVC]
        
        //print("cart VC from TabBar address: \(Unmanaged.passUnretained(cartVC).toOpaque())")
        print("MainTabBarController address: \(Unmanaged.passUnretained(self).toOpaque())")
    }
    
    private func fetchData(from url: String) {
        NetworkManager.shared.fetchCatalogue(from: url) { result in
            switch result {
            case .success(let catalogue):
                self.catalogue = catalogue
                CatalogueDataManager.shared.setCatalogue(catalogue: catalogue)
                self.setupViewControllers()
            case .failure(let error):
                print(error)
            }
        }
//        NetworkManager.shared.fetchCatalogue(from: url) { [weak self] catalogue in
//            self?.catalogue = catalogue
//            CatalogueDataManager.shared.setCatalogue(catalogue: catalogue)
//            self?.setupViewControllers()
//        }
    }
}


