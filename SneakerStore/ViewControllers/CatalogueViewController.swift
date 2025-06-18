//
//  CatalogueViewController.swift
//  SneakerStore
//
//  Created by Alex on 24.04.2025.
//

import UIKit

class CatalogueViewController: UIViewController {
    
    private let screen = UIScreen.main.bounds
    private let mainView = CatalogueView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        view.overrideUserInterfaceStyle = .light // ?
        
        //mainView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) { // исчезает крупный title при переходе обратно с details
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        mainView.collectionView.reloadData()
    }
    
    func openDetailPage(sneaker: Sneaker) {
        let sneakerDetailVC = SneakerDetailViewController(sneaker: sneaker)
        sneakerDetailVC.hidesBottomBarWhenPushed = true
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
       
        navigationController?.pushViewController(sneakerDetailVC, animated: true)
    }
}

//MARK: - Private methods
extension CatalogueViewController {
    private func setupNavBar() {
        navigationItem.title = "Kick lab"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

//MARK: - Data source methods
extension CatalogueViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CatalogueDataManager.shared.returnCatalogueCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogueCell.identifier, for: indexPath) as? CatalogueCell else { return UICollectionViewCell() }
        
        let sneaker = CatalogueDataManager.shared.catalogue[indexPath.item]
        cell.configure(with: sneaker)
        cell.delegate = self
            
        return cell
    }
}

//MARK: - Collection view delegate flow layout
extension CatalogueViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item % 3 == 2 { // делимое / делитель (большая коробка / маленькая)
            .init(width: screen.width - 16, height: (screen.width - 16) / 2 * 2 /*/ 3 * 2*/)
        } else {
            .init(width: screen.width / 2 - 13, height: screen.height / 2 - 40 /*- 200*/)
        }
    }
}
