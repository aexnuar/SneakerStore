//
//  CartViewController.swift
//  SneakerStore
//
//  Created by Alex on 24.04.2025.
//

import UIKit

class CartViewController: UIViewController {
    
    private let mainView = CartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSummaryTitle()
        mainView.tableView.reloadData()
    }
    
    private func setupSummaryTitle() {
        mainView.itemsLabel.text = String(CartDataManager.shared.sneakers.count) + " товара – " // настроить товара, отображение суммы с пробелами
        
        var totalPrice = 0
        
        CartDataManager.shared.sneakers.forEach {
            let cleanPrice = $0.price.replacingOccurrences(of: " ", with: "")
            totalPrice += Int(cleanPrice) ?? 0
        }
        
        mainView.totalPriceLabel.text = String(totalPrice) + " ₽"
    }
    
    private func setupNavigationBar() {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        let image = UIImage(systemName: "xmark", withConfiguration: imageConfig)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image, // уменьшить кнопку
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped))
        
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CartDataManager.shared.sneakers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.identifier, for: indexPath) as? CartCell else { return UITableViewCell() }
        let sneaker = CartDataManager.shared.sneakers[indexPath.row]
        cell.configure(with: sneaker)
        
        cell.removeCellButton.addTarget(self, action: #selector(removeCellButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    @objc private func removeCellButtonTapped(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? CartCell,
              let indexPath = mainView.tableView.indexPath(for: cell) else { return }
        
        CartDataManager.shared.sneakers.remove(at: indexPath.row)
        mainView.tableView.reloadData()
        tabBarController?.viewControllers?[2].tabBarItem.badgeValue = String(CartDataManager.shared.sneakers.count)
        // обновить тут бейдж через делегат
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainView.tableView.deselectRow(at: indexPath, animated: true)
        
        let sneakerDetailVC = SneakerDetailViewController(sneaker: CartDataManager.shared.sneakers[indexPath.row])
        present(sneakerDetailVC, animated: true)
    }
}

//extension CartViewController: AddToCartDelegate {
//    func addToCart(_ sneaker: Sneaker) {
//        CartDataManager.addToCart(sneaker: sneaker)
//        mainView.tableView.reloadData()
//    }
//}
