//
//  SneakerCarouselView.swift
//  SneakerStore
//
//  Created by Alex on 22.05.2025.
//

import UIKit

class SneakerCarouselView: UIView {
    
    var carouselCollectionView: UICollectionView!
    
    init() {
        super.init(frame: .zero)
        setupCarousel()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(dataSource: UICollectionViewDataSource & UICollectionViewDelegate) {
        carouselCollectionView.dataSource = dataSource
        carouselCollectionView.delegate = dataSource
        carouselCollectionView.reloadData()
    }
    
    private func setupCarousel() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 // ?
        
        carouselCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        carouselCollectionView.isPagingEnabled = true // ?
        carouselCollectionView.showsHorizontalScrollIndicator = false
        carouselCollectionView.layer.cornerRadius = 12 //delete later
        carouselCollectionView.register(CarouselImageCell.self, forCellWithReuseIdentifier: CarouselImageCell.identifier)
    }
    
    private func setupConstraints() {
        carouselCollectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(carouselCollectionView)
        
        NSLayoutConstraint.activate([
            carouselCollectionView.topAnchor.constraint(equalTo: topAnchor),
            carouselCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            carouselCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            carouselCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
