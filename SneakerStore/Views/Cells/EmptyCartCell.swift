//
//  EmptyCartCell.swift
//  SneakerStore
//
//  Created by aex on 14.09.2025.
//

import UIKit

class EmptyCartCell: UICollectionViewCell {
    
    static let identifier = "EmptyCartCell"
    
    private let brandLabel = UILabel(isBold: true, fontSize: 22)
    private let sneakerLabel = UILabel(isBold: false, fontSize: 12)
    private let priceLabel = UILabel(isBold: false, fontSize: 12, fontColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
    private let sneakerImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with sneaker: Sneaker) {
        brandLabel.text = sneaker.brand
        sneakerLabel.text = sneaker.sneaker
        priceLabel.text = sneaker.price + " ₽"
        //sneakerImage.image = UIImage(named: sneaker.sneakerImages[0])
        
        guard let sneakerImage = sneaker.sneakerImages.first else { return }
        
        NetworkManager.shared.fetchImage(from: sneakerImage) { data in
            guard let image = UIImage(data: data) else { return }
            self.sneakerImage.image = image
        }
    }
}

// MARK: - Private methods
extension EmptyCartCell {
    private func setupViews() {
        backgroundColor = .white
        
        sneakerImage.contentMode = .scaleAspectFill
        sneakerImage.clipsToBounds = true
        sneakerImage.layer.cornerRadius = 12
        
        [sneakerLabel, priceLabel].forEach {
            $0.textAlignment = .left
            $0.numberOfLines = 0
        }
        
        brandLabel.textAlignment = .left
        brandLabel.numberOfLines = 1
        brandLabel.adjustsFontSizeToFitWidth = true
        brandLabel.minimumScaleFactor = 0.7
        
        layer.borderWidth = 1.2
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
        layer.cornerRadius = 12
    }
    
    private func setupConstraints() {
        let stack = UIStackView(views: [brandLabel, sneakerLabel, priceLabel], alignment: .leading, axis: .vertical, spacing: 6)
        
        [sneakerImage, stack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        let centerGuide = UILayoutGuide()
        contentView.addLayoutGuide(centerGuide)
        
        NSLayoutConstraint.activate([
            sneakerImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            sneakerImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sneakerImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sneakerImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.70),
            
            centerGuide.topAnchor.constraint(equalTo: sneakerImage.bottomAnchor),
            centerGuide.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            stack.centerYAnchor.constraint(equalTo: centerGuide.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
    }
}
