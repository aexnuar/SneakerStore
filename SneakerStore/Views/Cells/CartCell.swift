//
//  CartCell.swift
//  SneakerStore
//
//  Created by aex on 28.04.2025.
//

import UIKit

class CartCell: UITableViewCell {
    
    static let identifier = "CartCell"
    
    let removeCellButton = UIButton()
    
    private let containerView = UIView()
    
    private let sneakerImage = UIImageView(image: UIImage())
    
    private let brandLabel = UILabel(isBold: true, fontSize: 22)
    private let sneakerLabel = UILabel(isBold: false, fontSize: 12)
    private let priceLabel = UILabel(isBold: false, fontSize: 12, fontColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        //sneakerImage.image = UIImage(named: sneaker.sneakerImages.first ?? "")
        
        guard let sneakerImage = sneaker.sneakerImages.first else { return }
        
        NetworkManager.shared.fetchImage(from: sneakerImage) { data in
            guard let image = UIImage(data: data) else { return }
            self.sneakerImage.image = image
            
        }
    }
    
    private func setupViews() {
        selectionStyle = .none /// скрывает выделение ячейки серым при нажатии
        
        containerView.layer.borderWidth = 1.2
        containerView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
        containerView.layer.cornerRadius = 12
        
        sneakerImage.layer.cornerRadius = 12
        sneakerImage.contentMode = .scaleAspectFill
        sneakerImage.clipsToBounds = true
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        let image = UIImage(systemName: "xmark", withConfiguration: imageConfig)
        removeCellButton.setImage(image, for: .normal)
        removeCellButton.tintColor = .label
        
        [brandLabel, sneakerLabel, priceLabel].forEach { $0.numberOfLines = 0 }
    }
    
    private func setupConstraints() {
        let labelsStack = UIStackView(
            views: [brandLabel, sneakerLabel, priceLabel],
            alignment: .leading,
            axis: .vertical,
            spacing: 10
        )
        
        [containerView, sneakerImage, labelsStack, removeCellButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            sneakerImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            sneakerImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            sneakerImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            sneakerImage.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.35),
            
            labelsStack.leadingAnchor.constraint(equalTo: sneakerImage.trailingAnchor, constant: 12),
            labelsStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            labelsStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            removeCellButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            removeCellButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        ])
    }
}

