//
//  NetworkService.swift
//  SneakerStore
//
//  Created by aex on 23.09.2025.
//

import Foundation

//enum NeworkError: Error {
//    case invalidURL, noData, decodingError
//}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCatalogue(from url: String, with completion: @escaping([Sneaker]) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let catalogue = try JSONDecoder().decode([Sneaker].self, from: data)
                DispatchQueue.main.async {
                    completion(catalogue)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchImage(from url: String?, with completion: @escaping(Data) -> Void) {
        guard let stringUrl = url else { return }
        guard let imageURL = URL(string: stringUrl) else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    
}

//func fetchImage(from url: String?, with completion: @escaping(UIImage) -> Void) {
//    guard let stringUrl = url else { return }
//    guard let imageURL = URL(string: stringUrl) else { return }
//    
//    DispatchQueue.global().async {
//        guard let data = try? Data(contentsOf: imageURL) else { return }
//        DispatchQueue.main.async {
//            completion(UIImage(data: data) ?? UIImage())
//        }
//    }
//}

