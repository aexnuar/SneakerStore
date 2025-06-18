//
//  CatalogueView.swift
//  SneakerStore
//
//  Created by Alex on 24.04.2025.
//

import UIKit

class CatalogueView: UIView {
    
    var collectionView: UICollectionView! // почему ошибка если так написать = UICollectionView()
    
    //weak var delegate: CatalogueViewController?
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        setupCollectionView()
        //setupTapGesture()
        setupSubviews(collectionView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func setupTapGesture() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(carouselTapped))
//        addGestureRecognizer(tap)
//    }

//    @objc private func carouselTapped() {
//        delegate?.openDetailPage(sneaker: <#T##Sneaker#>)
//    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(CatalogueCell.self, forCellWithReuseIdentifier: CatalogueCell.identifier)
        collectionView.contentInset = .init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
