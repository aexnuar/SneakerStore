//
//  SneakerDetailViewController.swift
//  SneakerStore
//
//  Created by Alex on 24.04.2025.
//

import UIKit

//protocol AddToCartDelegate: UIViewController {
//    func addToCart(_ sneaker: Sneaker)
//}

class SneakerDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private lazy var mainView = SneakerDetailView()
    //private let cartVC = CartViewController()
    private var sneaker: Sneaker

    //weak var delegate: AddToCartDelegate?
    
    init(sneaker: Sneaker) {
        self.sneaker = sneaker
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate = cartVC
        mainView.carouselView.set(dataSource: self)
        
        setupNavigationBar()
        setupViews()
        setupActions()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sneaker.sneakerImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselImageCell.identifier, for: indexPath) as? CarouselImageCell else { return UICollectionViewCell() }
        
        let imageName = sneaker.sneakerImages[indexPath.item]
        cell.configure(with: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: contentView.frame.width, height: contentView.frame.height * 0.75)
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

// MARK: - Private methods
extension SneakerDetailViewController {
    private func setupViews() {
        //mainView.snфeakerImage.image = UIImage(named: sneaker.sneakerImage)
        mainView.configure(brand: sneaker.brand, sneaker: sneaker.sneaker, price: sneaker.price)
//        mainView.brandLabel.text = sneaker.brand
//        mainView.sneakerLabel.text = sneaker.sneaker
//        mainView.priceLabel.text = sneaker.price + " ₽"
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .label
        
        let barButtonItem = UIBarButtonItem(customView: mainView.cartButton)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func setupActions() {
        mainView.addToCartButton.addTarget(self, action: #selector(configureAddToCartButton), for: .touchUpInside)
        mainView.cartButton.addTarget(self, action: #selector(openCart), for: .touchUpInside)
    }
    
    @objc private func configureAddToCartButton() {
        //delegate?.addToCart(sneaker)
        CartDataManager.shared.sneakers.append(sneaker)
        print("data sent to cartvc")
        
        let cartCount = CartDataManager.shared.sneakers.count
        
        if cartCount > 0 {
            tabBarController?.viewControllers?[2].tabBarItem.badgeValue = String(cartCount)
            mainView.badgeLabel.isHidden = false
            mainView.badgeLabel.text = String(cartCount)
        }
        
        configureBottomSheet()
    }
    
    @objc private func openCart() {
        let cartVC = CartViewController()
        let navigationVC = UINavigationController(rootViewController: cartVC)
        navigationVC.modalPresentationStyle = .fullScreen
        
        present(navigationVC, animated: true)
    }
    
    private func configureBottomSheet() {
        let cartBottomSheetVC = CartBottomSheetViewController()
        let navVC = UINavigationController(rootViewController: cartBottomSheetVC)
        
        cartBottomSheetVC.sneaker = sneaker
        
        if let sheet = navVC.sheetPresentationController {
            sheet.preferredCornerRadius = 20
            sheet.detents = [.custom(resolver: { context in
                0.38 * context.maximumDetentValue
            })]
            sheet.largestUndimmedDetentIdentifier = nil
        }
        
        present(navVC, animated: true)
    }
}
