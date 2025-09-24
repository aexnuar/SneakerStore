//
//  CarouselImageCell.swift
//  SneakerStore
//
//  Created by aex on 12.05.2025.
//

import UIKit

class CarouselImageCell: UICollectionViewCell {

    static let identifier = "CarouselImageCell"

    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            imageView.image = nil // сбрасываем на переиспользование
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    func configure(with imageName: String) {
//        imageView.image = UIImage(named: imageName)
//    }
    
    func configure(with imageURL: String) {
        //imageView.image = nil // сброс на момент загрузки
        
        NetworkManager.shared.fetchImage(from: imageURL) { data in
            guard let image = UIImage(data: data) else { return }
            self.imageView.image = image
        }
    }

    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
