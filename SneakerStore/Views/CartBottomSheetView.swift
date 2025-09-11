//
//  CartBottomSheetView.swift
//  SneakerStore
//
//  Created by aex on 30.04.2025.
//

import UIKit

class CartBottomSheetView: UIView {
    
    private let brandLabel = UILabel(isBold: true, fontSize: 22)
    private let sneakerLabel = UILabel(isBold: false, fontSize: 12)
    private let priceLabel = UILabel(isBold: false, fontSize: 12, fontColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
    private let titleLabel = UILabel(isBold: true, fontSize: 16)
    
    private let continueShoppingButton = UIButton(title: "Продолжить покупки")
    private let showCartButton = UIButton(title: "Перейти в корзину")
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: SneakerViewModel) {
        brandLabel.text = viewModel.brand
        sneakerLabel.text = viewModel.sneaker
        priceLabel.text = viewModel.price + " ₽"
    }
    
    //    func addAction(for button: UIButton, action: Selector) -> () {
    //        button.addTarget(self, action: action, for: .touchUpInside)
    //    }
    
    func addActionForContinueShoppingButton(target: Any?, action: Selector) {
        continueShoppingButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addActionForShowCartButton(target: Any?, action: Selector) -> () {
        showCartButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    private func setupViews() {
        titleLabel.text = "Товар добавлен в корзину".uppercased()
        
        showCartButton.backgroundColor = .white
        showCartButton.tintColor = .black
        showCartButton.layer.borderWidth = 1.2
        showCartButton.layer.borderColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    }
    
    private func setupConstraints() {
        let buttonsStack = UIStackView(views: [continueShoppingButton, showCartButton], axis: .vertical, spacing: 10)
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
