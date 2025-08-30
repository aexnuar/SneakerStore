//
//  Catalogue.swift
//  SneakerStore
//
//  Created by aex on 24.04.2025.
//

import Foundation

struct Sneaker: Equatable {
    
    let brand: String
    let sneaker: String
    let price: String
    let sizesAvailable: [Sizes]
    let sneakerImages: [String]
    var isFavorite = false
    
    static func getCatalogue() -> [Sneaker] {
        [
            Sneaker(brand: "Acne Studios", sneaker: "Текстильные кеды", price: "39 950", sizesAvailable: [.size40, .size41, .size42, .size43], sneakerImages: ["AcneStudios-1", "AcneStudios-2", "AcneStudios-3", "AcneStudios-4", "AcneStudios-5", "AcneStudios-6"]),
            Sneaker(brand: "Rick Owens", sneaker: "Кожаные кеды Hollywood Jumbolace", price: "114 000", sizesAvailable: [.size40, .size41, .size42, .size43], sneakerImages: ["RickOwens-1", "RickOwens-3", "RickOwens-4", "RickOwens-5", "RickOwens-6", "RickOwens-7", "RickOwens-8" ]),
            Sneaker(brand: "Burberry", sneaker: "Кеды Bubble", price: "84 950", sizesAvailable: [.size40, .size41, .size42, .size43], sneakerImages: ["Burberry-1", "Burberry-2", "Burberry-3", "Burberry-4", "Burberry-5", "Burberry-6", "Burberry-7"]),
            Sneaker(brand: "Balenciaga", sneaker: "Текстильные кеды Paris", price: "99 500", sizesAvailable: [.size40, .size41, .size42, .size43], sneakerImages: ["Balenciaga-1", "Balenciaga-2", "Balenciaga-3", "Balenciaga-4", "Balenciaga-5", "Balenciaga-6"]),
            Sneaker(brand: "Crime London", sneaker: "Комбинированные кеды Skate", price: "25 000", sizesAvailable: [.size40, .size41, .size42, .size43], sneakerImages: ["CrimeLondon-1", "CrimeLondon-2", "CrimeLondon-3", "CrimeLondon-4", "CrimeLondon-5", "CrimeLondon-6", "CrimeLondon-7"]),
            Sneaker(brand: "Dolce & Gabbana", sneaker: "Комбинированные кеды", price: "75 000", sizesAvailable: [.size40, .size41, .size42, .size43], sneakerImages: ["DolceAndGabbana-1", "DolceAndGabbana-2", "DolceAndGabbana-3", "DolceAndGabbana-4", "DolceAndGabbana-5", "DolceAndGabbana-6"]),
            Sneaker(brand: "Mattia Capezzani", sneaker: "Текстильные кеды Mamba", price: "68 750", sizesAvailable: [.size40, .size41, .size42, .size43], sneakerImages: ["MattiaCapezzani-1", "MattiaCapezzani-2", "MattiaCapezzani-3", "MattiaCapezzani-4", "MattiaCapezzani-5", "MattiaCapezzani-6", "MattiaCapezzani-7"]),
            Sneaker(brand: "Ann Demeulemeester", sneaker: "Замшевые кеды Nono", price: "93 600", sizesAvailable: [.size40, .size41, .size42, .size43], sneakerImages: ["AnnDemeulemeester-1", "AnnDemeulemeester-2", "AnnDemeulemeester-3", "AnnDemeulemeester-4", "AnnDemeulemeester-5", "AnnDemeulemeester-6", "AnnDemeulemeester-7", "AnnDemeulemeester-8"])
        ]
    }
}

enum Sizes: String {
    case size40 = "40"
    case size41 = "41"
    case size42 = "42"
    case size43 = "43"
    case size44 = "44"
    case size45 = "45"
}
