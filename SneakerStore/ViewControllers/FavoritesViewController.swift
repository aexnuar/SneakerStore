//
//  FavoritesViewController.swift
//  SneakerStore
//
//  Created by aex on 24.04.2025.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let screen = UIScreen.main.bounds
    private lazy var mainView = FavoriteView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainView.collectionView.reloadData()
        configureSummaryTitle()
    }
}

// MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CatalogueDataManager.shared.getFavoritesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else { return UICollectionViewCell() }
        
        let sneaker = CatalogueDataManager.shared.getFavoriteSneaker(at: indexPath)
    
        cell.configure(with: sneaker)
        
        cell.delegate = self
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: screen.width / 2 - 13, height: screen.height / 2 - 30)
    }
}

// MARK: - Private methods
extension FavoritesViewController {
    private func configureSummaryTitle() {
        mainView.itemsLabel.text = String(CatalogueDataManager.shared.getFavoritesCount()) + " товара"
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Избранное"
        navigationController?.navigationBar.tintColor = .label
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 14, weight: .medium),
            .foregroundColor: UIColor.label
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "cart"),
            style: .plain,
            target: self,
            action: #selector(showCart)
        )
    }
    
    @objc private func showCart() {
        let cartVC = CartViewController()
        let navCartVC = UINavigationController(rootViewController: cartVC)
        navCartVC.modalPresentationStyle = .fullScreen
        
        present(navCartVC, animated: true)
    }
}

extension FavoritesViewController: FavoriteCellDelegate {
    func reloadFavorites() {
        mainView.collectionView.reloadData() // TODO: реализовать обовление конкретной ячейки
    }
}
