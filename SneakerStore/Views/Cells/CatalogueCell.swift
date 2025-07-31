//
//  CatalogueCell.swift
//  SneakerStore
//
//  Created by Alex on 25.04.2025.
//

import UIKit

class CatalogueCell: UICollectionViewCell {
    
    static let identifier = "CatalogueCell"
    
    weak var delegate: CatalogueViewController?
    
    var sneaker: Sneaker?
    
    let favoriteButton = UIButton()
    
    private let brandLabel = UILabel(isBold: true, fontSize: 22)
    private let sneakerLabel = UILabel(isBold: false, fontSize: 12)
    private let priceLabel = UILabel(isBold: false, fontSize: 12, fontColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
    
    private let carouselView = SneakerCarouselView()
    private var sneakerCarouselVC: SneakerCarouselViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brown
        setupViews()
        print("setupActionsCalled")
        setupActions()
        setupConstraints()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with sneaker: Sneaker) {
        brandLabel.text = sneaker.brand
        sneakerLabel.text = sneaker.sneaker
        priceLabel.text = sneaker.price + " ₽"
        
        self.sneaker = sneaker
        
        sneakerCarouselVC = SneakerCarouselViewModel(images: sneaker.sneakerImages)
        guard let carouselVC = sneakerCarouselVC else { return }
        carouselView.set(dataSource: carouselVC)
        
        let isFavorite = sneaker.isFavorite /*?? false*/
        favoriteButton.setImage(UIImage(systemName: isFavorite ? "heart.fill" : "heart"), for: .normal)
        favoriteButton.tintColor = .label
    }
    
    private func setupViews() {
        [brandLabel, sneakerLabel, priceLabel].forEach {
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
        
        layer.cornerRadius = 12
        clipsToBounds = true
        
        layer.borderWidth = 1.2
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
        layer.cornerRadius = 12
        
        //favoriteButton.isUserInteractionEnabled = true
        //carouselView.isUserInteractionEnabled = true // 👈 если ты НЕ хочешь, чтобы он перехватывал жесты
    }
    
    private func setupConstraints() {
        let stack = UIStackView(views: [brandLabel, sneakerLabel, priceLabel], axis: .vertical, spacing: 2)
        
        [carouselView, stack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        //sneakerImage.isUserInteractionEnabled = true
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        carouselView.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            carouselView.topAnchor.constraint(equalTo: contentView.topAnchor),
            carouselView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            carouselView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            carouselView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),
            
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            stack.topAnchor.constraint(equalTo: carouselView.bottomAnchor, constant: 0),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

// MARK: - Action methods
extension CatalogueCell {
    private func setupActions() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        print("Target added")
    }
    
    @objc private func favoriteButtonTapped() {
        print("Favorite button tapped")
        guard var sneaker = sneaker else { return }
        print("Guard through")
        
        sneaker.isFavorite.toggle()
        favoriteButton.setImage(UIImage(systemName: sneaker.isFavorite ? "heart.fill" : "heart"), for: .normal)
        
        CatalogueDataManager.shared.addToFavorites(sneaker: sneaker)
    }
}

// MARK: - Tap gesture recognizer
extension CatalogueCell {
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(carouselTapped))
        addGestureRecognizer(tap)
    }
    
    @objc private func carouselTapped() {
        guard let sneaker = self.sneaker else { return }
        delegate?.openDetailPage(sneaker: sneaker)
    }
}



