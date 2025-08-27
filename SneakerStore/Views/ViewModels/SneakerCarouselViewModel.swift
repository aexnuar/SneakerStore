//
//  SneakerCarouselViewModel.swift
//  SneakerStore
//
//  Created by Alex on 22.05.2025.
//

import UIKit

class SneakerCarouselViewModel: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var images: [String]
    
    init(images: [String]) {
        self.images = images
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselImageCell.identifier, for: indexPath) as? CarouselImageCell else { return UICollectionViewCell() }
        
        cell.configure(with: images[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: contentView.frame.width, height: contentView.frame.height * 0.75)
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
