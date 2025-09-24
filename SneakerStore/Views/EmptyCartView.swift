//
//  EmptyCartView.swift
//  SneakerStore
//
//  Created by aex on 13.09.2025.
//

import UIKit

class EmptyCartView: UIView {
    
    let titleLabel = UILabel(isBold: true, fontSize: 22, fontColor: .label)
    let subtitleLabel = UILabel(isBold: false, fontSize: 14, fontColor: .label)
    
    let catalogueButton = UIButton(title: "Открыть каталог")
    
    var collectionView: UICollectionView!
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        setupViews()
        setupCollectionView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        titleLabel.text = "Товаров пока нет"
        subtitleLabel.text = "Для выбора вещей перейдите в каталог"
        
        [titleLabel, subtitleLabel].forEach { $0.textAlignment = .center }
        
        catalogueButton.backgroundColor = .label
        catalogueButton.tintColor = .white
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(EmptyCartCell.self, forCellWithReuseIdentifier: EmptyCartCell.identifier)
        //collectionView.contentInset = .init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    private func setupConstraints() {
        let stack = UIStackView(views: [titleLabel, subtitleLabel], alignment: .center, axis: .vertical, spacing: 10)
        
        [stack, catalogueButton, collectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            catalogueButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 60),
            catalogueButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            catalogueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            catalogueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            collectionView.topAnchor.constraint(equalTo: catalogueButton.bottomAnchor, constant: 80),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -80)
            
        ])
    }
}
