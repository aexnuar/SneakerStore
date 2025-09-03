//
//  CatalogueViewController.swift
//  SneakerStore
//
//  Created by aex on 24.04.2025.
//

import UIKit

class CatalogueViewController: UIViewController {
    
    // MARK: - Properties
    private let screen = UIScreen.main.bounds
    private lazy var mainView = CatalogueView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() { /// если в методе есть овверайд, то скорее всего необходим вызов супер
        super.viewDidLoad()
        
        view.overrideUserInterfaceStyle = .light /// принудительная установка светлой темы
        
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
       /*mainView.collectionView.reloadData()*/ /// лучше делать в дидаппир, потому что тут еще неизвестны размеры фреймов и ячеек,
    }
    
    // MARK: - Public methods
    func showDetailPage(with sneaker: Sneaker) {
        let sneakerDetailVC = SneakerDetailViewController(sneaker: sneaker)
        sneakerDetailVC.hidesBottomBarWhenPushed = true
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(sneakerDetailVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension CatalogueViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CatalogueDataManager.shared.getCatalogueCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogueCell.identifier, for: indexPath) as? CatalogueCell else { return UICollectionViewCell() }
        
        let sneaker = CatalogueDataManager.shared.catalogue[indexPath.item]
        cell.configure(with: sneaker)
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CatalogueViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item % 3 == 2 {
            .init(width: screen.width - 16, height: (screen.width - 16) / 2 * 2)
        } else {
            .init(width: screen.width / 2 - 13, height: screen.height / 2 - 40)
        }
    }
}

// MARK: - Private methods
extension CatalogueViewController {
    private func setupNavigationBar() {
        navigationItem.title = "Kick lab"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}


