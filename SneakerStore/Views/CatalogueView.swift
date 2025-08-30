//
//  CatalogueView.swift
//  SneakerStore
//
//  Created by aex on 24.04.2025.
//

import UIKit

class CatalogueView: UIView {
    
    var collectionView: UICollectionView! //TODO: уйти от принудительного извелечения?
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        setupCollectionView()
        setupConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(CatalogueCell.self, forCellWithReuseIdentifier: CatalogueCell.identifier)
        collectionView.contentInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
