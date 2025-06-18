//
//  FavoritesViewController.swift
//  SneakerStore
//
//  Created by Alex on 24.04.2025.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let screen = UIScreen.main.bounds
    private let mainView = FavoriteView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        print("viewDidLoad")
        
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainView.collectionView.reloadData()
        setupSummaryTitle()
    }
}

//MARK: - Private methods
extension FavoritesViewController {
    private func setupSummaryTitle() {
        mainView.itemsLabel.text = String(CatalogueDataManager.shared.favorites.count) + " товара"
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Избранное"
        navigationController?.navigationBar.tintColor = .label
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 16, weight: .medium),
            .foregroundColor: UIColor.label
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "cart"),
            style: .plain,
            target: self,
            action: #selector(openCart)
        )
    }
    
    @objc private func openCart() {
        let cartVC = CartViewController()
        let navCartVC = UINavigationController(rootViewController: cartVC)
        navCartVC.modalPresentationStyle = .fullScreen
        
        present(navCartVC, animated: true)
    }
}

//MARK: - Data source methods
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CatalogueDataManager.shared.favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else { return UICollectionViewCell() }
        
        let sneaker = CatalogueDataManager.shared.favorites[indexPath.item]
        print(sneaker)
        cell.configure(with: sneaker)
        
        cell.delegate = self
        
        return cell
    }
}

//MARK: - Collection view delegate flow layout
extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: screen.width / 2 - 13, height: screen.height / 2 - 30)
    }
}

extension FavoritesViewController: FavoriteCellDelegate {
    func reloadFavorites() {
        mainView.collectionView.reloadData() // TODO: реализовать обовление конкретной ячейки 
    }
}
