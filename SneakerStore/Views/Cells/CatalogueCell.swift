//
//  CatalogueCell.swift
//  SneakerStore
//
//  Created by aex on 25.04.2025.
//

import UIKit

class CatalogueCell: UICollectionViewCell {
    
    static let identifier = "CatalogueCell"
    weak var delegate: CatalogueViewController?
    var sneaker: Sneaker?
    
    let favoriteButton = UIButton()
    
    private let carouselView = SneakerCarouselView()
    private var sneakerCarouselVM: SneakerCarouselViewModel?
    
    private let brandLabel = UILabel(isBold: true, fontSize: 22)
    private let sneakerLabel = UILabel(isBold: false, fontSize: 12)
    private let priceLabel = UILabel(isBold: false, fontSize: 12, fontColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brown
        setupViews()
        setupConstraints()
        setupActions()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with sneaker: Sneaker) {
        brandLabel.text = sneaker.brand
        sneakerLabel.text = sneaker.sneaker
        priceLabel.text = "\(sneaker.price) ₽"
        
        self.sneaker = sneaker
        
        sneakerCarouselVM = SneakerCarouselViewModel(images: sneaker.sneakerImages)
        guard let carouselVM = sneakerCarouselVM else { return }
        carouselView.set(dataSource: carouselVM)
        
        let isFavorite = sneaker.isFavorite
        favoriteButton.setImage(UIImage(systemName: isFavorite ? "heart.fill" : "heart"), for: .normal)
        favoriteButton.tintColor = .label
    }
    
    private func setupViews() {
        [sneakerLabel, priceLabel].forEach {
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
        
        brandLabel.textAlignment = .center
        /// уменьшение длинного текста лейбла до размера одной строки
        brandLabel.numberOfLines = 1
        brandLabel.adjustsFontSizeToFitWidth = true
        brandLabel.minimumScaleFactor = 0.7
        
        clipsToBounds = true
        layer.borderWidth = 1.2
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
        layer.cornerRadius = 12
    }
    
    private func setupConstraints() {
        let stack = UIStackView(views: [brandLabel, sneakerLabel, priceLabel], axis: .vertical, spacing: 2)
        
        [carouselView, favoriteButton, stack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        let centerGuide = UILayoutGuide() /// создание Layout guide для центрирования стека между каруселью и низом ячейки
        contentView.addLayoutGuide(centerGuide)
        
        NSLayoutConstraint.activate([
            carouselView.topAnchor.constraint(equalTo: contentView.topAnchor),
            carouselView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            carouselView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            carouselView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),
            
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            /// Layout guide между каруселью и низом
            centerGuide.topAnchor.constraint(equalTo: carouselView.bottomAnchor),
            centerGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            /// Стек по центру guide
            stack.centerYAnchor.constraint(equalTo: centerGuide.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

// MARK: - Action methods
extension CatalogueCell {
    private func setupActions() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func favoriteButtonTapped() {
        print("Favorite button tapped")
        guard var sneaker = sneaker else { return }
        
        sneaker.isFavorite.toggle()
        favoriteButton.setImage(UIImage(systemName: sneaker.isFavorite ? "heart.fill" : "heart"), for: .normal)
        
        CatalogueDataManager.shared.addToFavorites(sneaker: sneaker)
    }
}

// MARK: - UITapGestureRecognizer
extension CatalogueCell {
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(carouselTapped))
        addGestureRecognizer(tap)
    }
    
    @objc private func carouselTapped() {
        guard let sneaker = sneaker else { return }
        delegate?.showDetailPage(with: sneaker)
    }
}





