//
//  SneakerDetailViewController.swift
//  SneakerStore
//
//  Created by aex on 24.04.2025.
//

import UIKit

class SneakerDetailViewController: UIViewController {
    
    private lazy var mainView = SneakerDetailView()
    private var sneaker: Sneaker
    
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
        mainView.carouselView.set(dataSource: self)
        
        setupNavigationBar()
        setupViews()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBadge()
    }
}

// MARK: - UICollectionViewDataSource
extension SneakerDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sneaker.sneakerImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselImageCell.identifier, for: indexPath) as? CarouselImageCell else { return UICollectionViewCell() }
        
        let imageTitle = sneaker.sneakerImages[indexPath.item]
        cell.configure(with: imageTitle)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SneakerDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

// MARK: - Private methods
extension SneakerDetailViewController {
    private func setupViews() {
        mainView.configure(with: (
            .init(
                brand: sneaker.brand,
                sneaker: sneaker.sneaker,
                price: sneaker.price
            )
        ))
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .label
        
        let barButtonItem = UIBarButtonItem(customView: mainView.navCartButton)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func setupBadge() { // TODO: донастроить бейдж
        let cartCount = CartDataManager.shared.getCartCount()
        
        if cartCount > 0 {
            tabBarController?.viewControllers?[2].tabBarItem.badgeValue = String(cartCount)
            
            mainView.updateConstraintsForCartBadge(count: cartCount)
            
            mainView.badgeLabel.isHidden = false
            mainView.badgeLabel.text = String(cartCount)
        } else {
            tabBarController?.viewControllers?[2].tabBarItem.badgeValue = nil
            mainView.badgeLabel.isHidden = true
        }
    }
    
    private func setupActions() {
        mainView.navCartButton.addTarget(self, action: #selector(showCart), for: .touchUpInside)
        mainView.addToCartButton.addTarget(self, action: #selector(configureAddToCartButton), for: .touchUpInside)
    }
    
    @objc internal func showCart() { // TODO: why internal?
        let cartCount = CartDataManager.shared.getCartCount()
        
        let cartVC = cartCount > 0 ? CartViewController() : EmptyCartViewController()
        let navigationVC = UINavigationController(rootViewController: cartVC)
        navigationVC.modalPresentationStyle = .fullScreen
        
        present(navigationVC, animated: true)
    }
    
    @objc private func configureAddToCartButton() {
        CartDataManager.shared.addToCart(sneaker)
        StorageManager.shared.addOrUpdate(sneaker: sneaker, inCart: true)
        
        setupBadge()
        configureBottomSheet()
    }
    
    private func configureBottomSheet() {
        let cartBottomSheetVC = CartBottomSheetViewController()
        //let navVC = UINavigationController(rootViewController: cartBottomSheetVC)
        cartBottomSheetVC.sneaker = sneaker
        cartBottomSheetVC.delegate = self
        
        if let sheet = cartBottomSheetVC.sheetPresentationController {
            sheet.preferredCornerRadius = 20
            sheet.detents = [.custom(resolver: { context in
                0.38 * context.maximumDetentValue
            })]
            sheet.largestUndimmedDetentIdentifier = nil
        }
        
        present(cartBottomSheetVC, animated: true)
    }
}

// MARK: - CartBottomSheetViewControllerDelegate
extension SneakerDetailViewController: CartBottomSheetViewControllerDelegate {
    func openCartFromBottomSheet() {
        presentedViewController?.dismiss(animated: false)
        showCart()
    }
}
