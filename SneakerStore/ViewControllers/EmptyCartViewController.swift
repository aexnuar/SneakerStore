//
//  EmptyCartViewController.swift
//  SneakerStore
//
//  Created by aex on 13.09.2025.
//

import UIKit

class EmptyCartViewController: UIViewController {
    
    private lazy var mainView = EmptyCartView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        
        setupNavigationBar()
        setupActions()
    }
}

// MARK: - UICollectionViewDataSource
extension EmptyCartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CatalogueDataManager.shared.getCatalogueCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCartCell.identifier, for: indexPath) as? EmptyCartCell else { return UICollectionViewCell() }
        
        let sneaker = CatalogueDataManager.shared.getSneaker(at: indexPath)
        cell.configure(with: sneaker)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension EmptyCartViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let sneaker = CatalogueDataManager.shared.getSneaker(at: indexPath)
        let detailsVC = SneakerDetailViewController(sneaker: sneaker)
        let navDetailsVC = UINavigationController(rootViewController: detailsVC)
        navDetailsVC.modalPresentationStyle = .fullScreen
 
        navDetailsVC.setupNavBarWithCloseButton(target: self, action: #selector(closeButtonDetailsTapped))
        
        present(navDetailsVC, animated: true)
    }
    
    @objc private func closeButtonDetailsTapped() {
        dismiss(animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension EmptyCartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: mainView.collectionView.frame.width / 2 - 20, height: mainView.collectionView.frame.height)
    }
}

// MARK: - Private methods
extension EmptyCartViewController {
    private func setupNavigationBar() {
        navigationController?.setupNavBarWithCloseButton(target: self, action: #selector(closeButtonTapped))
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - Setup actions
extension EmptyCartViewController {
    private func setupActions() {
        mainView.catalogueButton.addTarget(self, action: #selector(showCatalogue), for: .touchUpInside)
    }
    
//    @objc private func showCatalogue() {
//        let mainVC = MainTabBarController()
//        //mainVC.modalPresentationStyle = .fullScreen
//        present(mainVC, animated: true)
//        
//        print("MainVC from EmptyCartViewController address: \(Unmanaged.passUnretained(mainVC).toOpaque())")
//    }
    
    @objc private func showCatalogue() {
        // Находим существующий TabBarController из иерархии окон
        guard let keyWindow = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }),
            let existingTabBarController = keyWindow.rootViewController as? MainTabBarController else {
            print("Не удалось найти главный TabBarController")
            return
        }
        
        print("Используем существующий TabBarController: \(Unmanaged.passUnretained(existingTabBarController).toOpaque())")
        
        // Закрываем текущий экран и переключаем вкладку
        dismiss(animated: true) {
            existingTabBarController.selectedIndex = 0 // Вкладка каталога
            
            // Дополнительно: возвращаемся к корню навигации
            if let catalogueNav = existingTabBarController.viewControllers?[0] as? UINavigationController {
                catalogueNav.popToRootViewController(animated: true)
            }
        }
    }
}
