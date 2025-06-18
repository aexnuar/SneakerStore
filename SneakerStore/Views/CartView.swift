//
//  CartView.swift
//  SneakerStore
//
//  Created by Alex on 28.04.2025.
//

import UIKit

class CartView: UIView {
    
    let itemsLabel = UILabel(isBold: false, fontSize: 14)
    let totalPriceLabel = UILabel(isBold: false, fontSize: 14, fontColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
    var tableView = UITableView()
    let checkoutButton = UIButton(title: "Оформить покупку")
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        setupTableView()
        setupSubviews(tableView, checkoutButton)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear // надо?
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.identifier)
        tableView.layer.cornerRadius = 12
        tableView.separatorStyle = .none
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        let labelsStack = UIStackView(views: [itemsLabel, totalPriceLabel], axis: .horizontal, spacing: 0)
        addSubview(labelsStack)
        
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelsStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            labelsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: labelsStack.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            tableView.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: 10),
            
            
            //checkoutButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            checkoutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            checkoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            checkoutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
