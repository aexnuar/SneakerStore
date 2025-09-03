//
//  SneakerDetailView.swift
//  SneakerStore
//
//  Created by aex on 27.04.2025.
//

import UIKit

class SneakerDetailView: UIView {
    
    let carouselView = SneakerCarouselView()
    
    let navCartButton = UIButton(type: .custom)
    let addToCartButton = UIButton(title: "В корзину")
    
    let badgeLabel = UILabel()
    
    private let brandLabel = UILabel(isBold: true, fontSize: 22)
    private let sneakerLabel = UILabel(isBold: false, fontSize: 12)
    private let priceLabel = UILabel(isBold: false, fontSize: 12, fontColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
    private let sizeLabel = UILabel(isBold: false, fontSize: 12)
    
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .brown // TODO: change to white
        
        setupCartButton()
        setupSubviews(carouselView, brandLabel, sneakerLabel, priceLabel)
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
    
    private func setupCartButton() {
        navCartButton.setImage(UIImage(systemName: "cart"), for: .normal)
        
        badgeLabel.font = .systemFont(ofSize: 13)
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = .systemRed
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 9
        badgeLabel.layer.masksToBounds = true
        
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        navCartButton.addSubview(badgeLabel)
        
        NSLayoutConstraint.activate([
            badgeLabel.topAnchor.constraint(equalTo: navCartButton.topAnchor, constant: -6),
            badgeLabel.trailingAnchor.constraint(equalTo: navCartButton.trailingAnchor, constant: 6),
            badgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 18),
            badgeLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        addSubview(scrollView)
        addSubview(addToCartButton)
        scrollView.addSubview(contentView)
        
        subviews.forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        let views = [
            scrollView, contentView,
            addToCartButton, carouselView,
            brandLabel, sneakerLabel,
            priceLabel, sizeLabel
        ]
        
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: addToCartButton.topAnchor, constant: -10),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            addToCartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            addToCartButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            carouselView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            carouselView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            carouselView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            carouselView.heightAnchor.constraint(equalToConstant: 580),
            
            brandLabel.topAnchor.constraint(equalTo: carouselView.bottomAnchor, constant: 16),
            brandLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            sneakerLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 6),
            sneakerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: sneakerLabel.bottomAnchor, constant: 5),
            priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
