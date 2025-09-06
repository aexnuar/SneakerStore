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
        
        cell.delegate = self
        cell.detailDelegate = self
        
        return cell
    }
}

//extension FavoritesViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let detailVC = SneakerDetailViewController(sneaker: CatalogueDataManager.shared.getSneaker(at: indexPath))
//        detailVC.hidesBottomBarWhenPushed = true
//        
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
//}

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
        configureItemsTitle()
        mainView.collectionView.reloadData() // TODO: реализовать обовление конкретной ячейки
    }
}

// MARK: - FavoriteCellDelegateToDetailPage
extension FavoritesViewController: FavoriteCellDelegateToDetailPage {
    func showDetailPage(with sneaker: Sneaker) {
        let sneakerDetailVC = SneakerDetailViewController(sneaker: sneaker)
        sneakerDetailVC.hidesBottomBarWhenPushed = true
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(sneakerDetailVC, animated: true)
    }
}
