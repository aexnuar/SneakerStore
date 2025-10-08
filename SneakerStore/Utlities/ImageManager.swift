//
//  GetImage.swift
//  SneakerStore
//
//  Created by aex on 08.10.2025.
//

import Foundation
import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    // Реализация работы с сохранением и получением картинок из кэша
    func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        // Get image from cache
        if let cacheImage = ImageCache.shared.object(forKey: url.lastPathComponent as NSString) {
            print("image from cache: ", url.lastPathComponent)
            completion(.success(cacheImage))
            return
        }
        
        // Download image from url
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else { return }
                ImageCache.shared.setObject(image, forKey: url.lastPathComponent as NSString)
                print("Image from network: ", url.lastPathComponent)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
