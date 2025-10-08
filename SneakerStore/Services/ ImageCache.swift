//
//   ImageCache.swift
//  SneakerStore
//
//  Created by aex on 08.10.2025.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
