//
//  NetworkService.swift
//  SneakerStore
//
//  Created by aex on 23.09.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL, noData, decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCatalogue(from url: String, with completion: @escaping(Result<[Sneaker], NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let catalogue = try JSONDecoder().decode([Sneaker].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(catalogue))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: String?, with completion: @escaping(Data) -> Void) {
        guard let stringUrl = url, let imageURL = URL(string: stringUrl) else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}

//    func fetchCatalogue(from url: String, with completion: @escaping([Sneaker]) -> Void) {
//        guard let url = URL(string: url) else { return }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            do {
//                let catalogue = try JSONDecoder().decode([Sneaker].self, from: data)
//                DispatchQueue.main.async {
//                    completion(catalogue)
//                }
//            } catch let error {
//                print(error)
//            }
//        }.resume()
//    }


