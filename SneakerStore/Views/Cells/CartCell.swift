//
//  CartCell.swift
//  SneakerStore
//
//  Created by Alex on 28.04.2025.
//

import UIKit

class CartCell: UITableViewCell {
    
    static let identifier = "CartCell"
    
    let removeCellButton = UIButton()
    
    private let sneakerImage = UIImageView(image: .acneStudios1)
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
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.frame = bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//    }
    
    func configure(with sneaker: Sneaker) {
        //backgroundColor = .gray
        //layer.cornerRadius = 20
        
        brandLabel.text = sneaker.brand
        sneakerLabel.text = sneaker.sneaker
        priceLabel.text = sneaker.price + " ₽"
        //sneakerImage.image = UIImage(named: sneaker.sneakerImage)
    }
    
    private func setupViews() {
        //contentView.backgroundColor = .green
        sneakerImage.layer.cornerRadius = 12
        sneakerImage.contentMode = .scaleAspectFill
        sneakerImage.clipsToBounds = true
        
        layer.borderWidth = 1.2
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
        layer.cornerRadius = 12
        
        clipsToBounds = true
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        let image = UIImage(systemName: "xmark", withConfiguration: imageConfig)
        removeCellButton.setImage(image, for: .normal)
        removeCellButton.tintColor = .label
        
        [brandLabel, sneakerLabel, priceLabel].forEach { $0.numberOfLines = 0 }
    }
    
    private func setupConstraints() {
        let labelsStack = UIStackView(views: [brandLabel, sneakerLabel, priceLabel], alignment: .leading, axis: .vertical, spacing: 10)
        
        sneakerImage.translatesAutoresizingMaskIntoConstraints = false
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        removeCellButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(sneakerImage)
        contentView.addSubview(labelsStack)
        contentView.addSubview(removeCellButton)
        
        NSLayoutConstraint.activate([
            sneakerImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            sneakerImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            sneakerImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            //sneakerImage.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            sneakerImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.35),
            
            labelsStack.leadingAnchor.constraint(equalTo: sneakerImage.trailingAnchor, constant: 12),
            labelsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            //            labelsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelsStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            removeCellButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            removeCellButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
}
