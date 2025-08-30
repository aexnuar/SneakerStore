//
//  CartViewController.swift
//  SneakerStore
//
//  Created by Alex on 24.04.2025.
//

import UIKit

protocol CartViewControllerDelegate: AnyObject { //!
    func reloadData()
}

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var mainView = CartView()
    
    weak var delegate: CartViewControllerDelegate? //!
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        //setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSummaryTitle()
        mainView.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CartDataManager.shared.getCartCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.identifier, for: indexPath) as? CartCell else { return UITableViewCell() }
        let sneaker = CartDataManager.shared.getSneaker(at: indexPath)
        cell.configure(with: sneaker)
        cell.removeCellButton.addTarget(self, action: #selector(removeCellButtonTapped), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainView.tableView.deselectRow(at: indexPath, animated: true)
        
        let sneakerDetailVC = SneakerDetailViewController(sneaker: CartDataManager.shared.getSneaker(at: indexPath))
        present(sneakerDetailVC, animated: true)
    }
}

// MARK: - Private methods
extension CartViewController {
    @objc private func removeCellButtonTapped(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? CartCell,
              let indexPath = mainView.tableView.indexPath(for: cell) else { return }
        
        CartDataManager.shared.removeFromCart(at: indexPath)
        mainView.tableView.reloadData()
        
        let cartCount = CartDataManager.shared.getCartCount()
        
        if cartCount > 0 {
            tabBarController?.viewControllers?[2].tabBarItem.badgeValue = String(cartCount)
        } else {
            tabBarController?.tabBar.items?[2].badgeValue = nil
        }
        
        delegate?.reloadData() //!
    }
    
    private func setupSummaryTitle() {
        mainView.itemsLabel.text = String(CartDataManager.shared.getCartCount()) + " товара – " // TODO: настроить падежи, отображение суммы с пробелами
        
        let totalPrice = CartDataManager.shared.getTotalPrice()
        
        mainView.totalPriceLabel.text = String(totalPrice) + " ₽"
    }
    
    //    private func setupNavigationBar() {
    //        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
    //        let image = UIImage(systemName: "xmark", withConfiguration: imageConfig)
    //
    //        navigationItem.leftBarButtonItem = UIBarButtonItem(
    //            image: image, // уменьшить кнопку
    //            style: .plain,
    //            target: self,
    //            action: #selector(closeButtonTapped)
    //        )
    //
    //        navigationItem.leftBarButtonItem?.tintColor = .black
    //    }
    
    //    @objc private func closeButtonTapped() {
    //        self.dismiss(animated: true)
    //    }
}
