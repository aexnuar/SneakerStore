//
//  FavoriteView.swift
//  SneakerStore
//
//  Created by Alex on 05.05.2025.
//

import UIKit

class FavoriteView: UIView {
        
    let itemsLabel = UILabel(isBold: false, fontSize: 12)
    
    var collectionView: UICollectionView!
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        setupCollectionView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.identifier)
        collectionView.contentInset = .init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    private func setupConstraints() {
        itemsLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //carouselView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(itemsLabel)
        addSubview(collectionView)
        //collectionView.addSubview(carouselView)
        
        NSLayoutConstraint.activate([
            itemsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            itemsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: itemsLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
