//
//  CartViewController.swift
//  SneakerStore
//
//  Created by aex on 24.04.2025.
//

import UIKit

protocol CartViewControllerDelegate: AnyObject { //!
    func reloadData()
}

class CartViewController: UIViewController {
    
    private lazy var mainView = CartView()
    
    weak var delegate: CartViewControllerDelegate? //!
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureFinalTitle()
        mainView.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension CartViewController: UITableViewDataSource {
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
}

// MARK: - UITableViewDelegate
extension CartViewController: UITableViewDelegate {
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
        
        configureFinalTitle()
        
        delegate?.reloadData() //!
    }
    
    private func configureFinalTitle() {
        let cartCount = CartDataManager.shared.getCartCount()
        let totalPrice = CartDataManager.shared.getTotalPrice()
        
        mainView.itemsLabel.text = "\(cartCount) \(DataFormatter.shared.formatItemWord(for: cartCount)) — "
        mainView.totalPriceLabel.text = "\(DataFormatter.shared.formatPrice(totalPrice)) ₽"
    }
    
    private func setupNavigationBar() {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        let image = UIImage(systemName: "xmark", withConfiguration: imageConfig)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let appearance = UINavigationBarAppearance() /// скрываем серый в нав баре при скролле тейбл вью снизу вверх
        appearance.configureWithTransparentBackground()
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
        //navigationController?.popViewController(animated: true)
    }
}
