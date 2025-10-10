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
    
    private var currentImageURL: URL? {
        didSet {
            imageView.image = nil
            updateImage()
        }
    }
    
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
    
    func configure(with imageURL: String) {
        currentImageURL = URL(string: imageURL)
    }
    
    private func updateImage() {
        guard let url = currentImageURL else { return }
        
        ImageManager.shared.getImage(from: url) { result in
            switch result {
            case .success(let image):
                if url == self.currentImageURL {
                    self.imageView.image = image
                }
            case .failure(let error):
                print(error)
            }
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


























//class CarouselImageCell: UICollectionViewCell {
//    static let identifier = "CarouselImageCell"
//
//    private let imageView = UIImageView()
//
//    private var currentImageURL: String? {
//        didSet {
//            // Если URL изменился — загружаем новую картинку
//            guard let imageURL = currentImageURL else {
//                imageView.image = nil
//                return
//            }
//            loadImage(urlString: imageURL)
//        }
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupImageView()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        currentImageURL = nil
//        imageView.image = nil
//    }
//
//    func configure(with imageURL: String) {
//        self.currentImageURL = imageURL
//    }
//
//    private func loadImage(urlString: String) {
//        NetworkManager.shared.fetchImage(from: urlString) { [weak self] data in
//            guard let self = self else { return }
//            // Проверяем, что URL не изменился за время загрузки
//            if self.currentImageURL != urlString { return }
//            if let image = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    self.imageView.image = image
//                }
//            }
//        }
//    }
//
//    private func setupImageView() {
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 12
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(imageView)
//
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
//}

//class CarouselImageCell: UICollectionViewCell {
//    static let identifier = "CarouselImageCell"
//
//    private let imageView = UIImageView()
//    private var currentImageURL: String?
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupImageView()
//    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        currentImageURL = nil
//        imageView.image = nil
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // Настройка ячейки новым url изображения
//    func configure(with imageURL: String) {
//        // 1. Запоминаем, какую картинку надо показать
//        currentImageURL = imageURL
//        imageView.image = nil // чтобы во время загрузки не видно было старую
//
//        // 2. Загружай картинку асинхронно (например, из интернета)
//        NetworkManager.shared.fetchImage(from: imageURL) { [weak self] data in
//            guard let self = self else { return }
//
//            // 3. Проверяй: актуален ли запрошенный URL
//            if self.currentImageURL != imageURL { return }
//
//            // 4. Показывай картинку только если всё до сих пор совпадает
//            if let image = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    self.imageView.image = image
//                }
//            }
//        }
//    }
//
//    private func setupImageView() {
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 12
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(imageView)
//
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
//}


