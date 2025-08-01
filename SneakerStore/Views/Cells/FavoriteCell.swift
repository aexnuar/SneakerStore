//
//  FavoriteCell.swift
//  SneakerStore
//
//  Created by Alex on 05.05.2025.
//

import UIKit

protocol FavoriteCellDelegate: AnyObject {
    func reloadFavorites()
}

class FavoriteCell: UICollectionViewCell {
    
    static let identifier = "FavoriteCell"
    
    var sneaker: Sneaker?
    
    weak var delegate: FavoriteCellDelegate?
    
    private let carouselView = SneakerCarouselView()
    private var sneakerCarouselVC: SneakerCarouselViewModel?
    
    private let removeCellButton = UIButton()
    
    //private let sneakerImages = UIImageView()
    private let brandLabel = UILabel(isBold: true, fontSize: 22)
    private let sneakerLabel = UILabel(isBold: false, fontSize: 12)
    private let priceLabel = UILabel(isBold: false, fontSize: 12, fontColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
    private let addToCartButton = UIButton(title: "В корзину")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupActions()
        setupConstraints()
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
    }
    
    private func setupViews() {
//        sneakerImages.isUserInteractionEnabled = true
//        
//        sneakerImages.contentMode = .scaleAspectFill
//        sneakerImages.clipsToBounds = true
        
        addToCartButton.titleLabel?.font = .systemFont(ofSize: 12)
        addToCartButton.layer.cornerRadius = 6
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        let image = UIImage(systemName: "xmark", withConfiguration: imageConfig)
        removeCellButton.setImage(image, for: .normal)
        removeCellButton.tintColor = .label
        
        [brandLabel, sneakerLabel, priceLabel].forEach {
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
    }
    
    private func setupConstraints() {
        let stack = UIStackView(views: [brandLabel, sneakerLabel, priceLabel], alignment: .center, axis: .vertical, spacing: 2)
        
        [/*sneakerImages*/carouselView, stack, addToCartButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        removeCellButton.translatesAutoresizingMaskIntoConstraints = false
        carouselView.addSubview(removeCellButton)
        
        NSLayoutConstraint.activate([
            carouselView.topAnchor.constraint(equalTo: topAnchor),
            carouselView.leadingAnchor.constraint(equalTo: leadingAnchor),
            carouselView.trailingAnchor.constraint(equalTo: trailingAnchor),
            carouselView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.70),
            
            removeCellButton.topAnchor.constraint(equalTo: carouselView.topAnchor, constant: 12),
            removeCellButton.trailingAnchor.constraint(equalTo: carouselView.trailingAnchor, constant: -12),
            
            stack.topAnchor.constraint(equalTo: carouselView.bottomAnchor, constant: 0),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            addToCartButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 6),
            addToCartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            addToCartButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

// MARK: - Action methods
extension FavoriteCell {
    private func setupActions() {
        removeCellButton.addTarget(self, action: #selector(removeCellButtonTapped), for: .touchUpInside)
    }
    
    @objc private func removeCellButtonTapped() {
        guard let sneaker = sneaker else { return }
        print("Кнопка удаления нажата для: \(sneaker)")
        
        CatalogueDataManager.shared.removeFromFavorites(sneaker: sneaker)
        
        //sneaker.isFavorite.toggle()
        self.sneaker?.isFavorite = false

        delegate?.reloadFavorites()
    }
}
