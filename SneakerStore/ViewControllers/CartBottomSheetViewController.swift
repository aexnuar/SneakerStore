//
//  CartBottomSheetViewController.swift
//  SneakerStore
//
//  Created by Alex on 30.04.2025.
//

import UIKit

class CartBottomSheetViewController: UIViewController {
    
    var sneaker: Sneaker?
    
    private let mainView = CartBottomSheetView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        
        setupViews()
        setupActions()
    }
}

//MARK: - Private methods
extension CartBottomSheetViewController {
    private func setupViews() {
        guard let sneaker = sneaker else {
            print("No data in cart sheet")
            return
        }
        
        mainView.brandLabel.text = sneaker.brand
        mainView.sneakerLabel.text = sneaker.sneaker
        mainView.priceLabel.text = sneaker.price + " ₽"
    }
    
    private func setupActions() {
        mainView.continueShoppingButton.addTarget(self, action: #selector(continueShoppingButtonTapped), for: .touchUpInside)
        mainView.goToCartButton.addTarget(self, action: #selector(goToCartButtonTapped), for: .touchUpInside)
    }
    
    @objc private func continueShoppingButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func goToCartButtonTapped() {
        let cartVC = CartViewController()
        let navVC = UINavigationController(rootViewController: cartVC)
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true)
    }
}
