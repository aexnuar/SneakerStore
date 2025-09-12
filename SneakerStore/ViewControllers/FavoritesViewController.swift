//
//  FavoritesViewController.swift
//  SneakerStore
//
//  Created by aex on 24.04.2025.
//

import UIKit

protocol FavoritesUpdateDelegate: AnyObject {
    func favoritesDidUpdate(for sneaker: Sneaker)
}

class FavoritesViewController: UIViewController {
    
    weak var favoritesDelegate: FavoritesUpdateDelegate?
    
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
        configureItemsTitle()
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
        
        cell.favoriteDelegate = self
        cell.detailDelegate = self
        
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
    private func configureItemsTitle() {
        let favoritesCount = CatalogueDataManager.shared.getFavoritesCount()
        
        mainView.itemsLabel.text = "\(favoritesCount) \(DataFormatter.shared.formatItemWord(for: favoritesCount))"
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
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            image: UIImage(systemName: "cart"),
//            style: .plain,
//            target: self,
//            action: #selector(showCart)
//        )
    }
    
//    @objc private func showCart() {
//        let cartVC = CartViewController()
//        let navCartVC = UINavigationController(rootViewController: cartVC)
//        navCartVC.modalPresentationStyle = .fullScreen
//        
//        present(navCartVC, animated: true)
//    }
}

// MARK: - FavoriteCellReloadDelegate
extension FavoritesViewController: FavoriteCellDelegate {
    func favoriteCellDidRequestUpdate(_ cell: FavoriteCell) {
        guard let index = mainView.collectionView.indexPath(for: cell) else { return }
        let sneaker = CatalogueDataManager.shared.getFavoriteSneaker(at: index)
        
        favoritesDelegate?.favoritesDidUpdate(for: sneaker)
        
        CatalogueDataManager.shared.removeFromFavorites(sneaker: sneaker) // удаление ячейки только после делегирования ее каталогу
        mainView.collectionView.reloadData()
        configureItemsTitle()
    }
}

// MARK: - FavoriteCellDelegateToDetailPage
extension FavoritesViewController: FavoriteCellDetailDelegate {
    func showDetailPage(with sneaker: Sneaker) {
        let sneakerDetailVC = SneakerDetailViewController(sneaker: sneaker)
        sneakerDetailVC.hidesBottomBarWhenPushed = true
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(sneakerDetailVC, animated: true)
    }
}
