//
//  CartBottomSheetViewController.swift
//  SneakerStore
//
//  Created by aex on 30.04.2025.
//

import UIKit

protocol CartBottomSheetViewControllerDelegate: AnyObject {
    func openCartFromBottomSheet()
}

class CartBottomSheetViewController: UIViewController {
    
    var sneaker: Sneaker?
    private lazy var mainView = CartBottomSheetView()
    weak var delegate: CartBottomSheetViewControllerDelegate?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupActions()
    }
}

// MARK: - Private methods
extension CartBottomSheetViewController {
    private func setupViews() {
        guard let sneaker = sneaker else {
            print("No data in cart sheet")
            return
        }
        
        mainView.configure(with: .init(
            brand: sneaker.brand,
            sneaker: sneaker.sneaker,
            price: sneaker.price
        ))
    }
    
    private func setupActions() {
        mainView.addActionForContinueShoppingButton(target: self, action: #selector(continueShoppingButtonTapped))
        mainView.addActionForShowCartButton(target: self, action: #selector(showCartButtonTapped))
    }
    
    @objc private func continueShoppingButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func showCartButtonTapped() {
        delegate?.openCartFromBottomSheet()
    }
}
