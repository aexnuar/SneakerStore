//
//  CartBottomSheetView.swift
//  SneakerStore
//
//  Created by Alex on 30.04.2025.
//

import UIKit

class CartBottomSheetView: UIView {
    
    let brandLabel = UILabel(isBold: true, fontSize: 22)
    let sneakerLabel = UILabel(isBold: false, fontSize: 12)
    let priceLabel = UILabel(isBold: false, fontSize: 12, fontColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
    
    let continueShoppingButton = UIButton(title: "Продолжить покупки")
    let goToCartButton = UIButton(title: "Перейти в корзину")
    
    private let titleLabel = UILabel(isBold: true, fontSize: 16)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupViews()
        setupConstreints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        titleLabel.text = "Товар добавлен в корзину".uppercased()
        
        goToCartButton.backgroundColor = .white
        goToCartButton.tintColor = .black
        goToCartButton.layer.borderWidth = 1.2
        goToCartButton.layer.borderColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    }
    
    private func setupConstreints() {
        let buttonsStack = UIStackView(views: [continueShoppingButton, goToCartButton], axis: .vertical, spacing: 10)
        let labelsStack = UIStackView(views: [sneakerLabel, priceLabel], alignment: .center, axis: .vertical, spacing: 4)
        
        [titleLabel, brandLabel, buttonsStack, labelsStack].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            brandLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            brandLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            labelsStack.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 12),
            labelsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            buttonsStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}
