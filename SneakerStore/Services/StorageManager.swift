//
//  StorageManager.swift
//  SneakerStore
//
//  Created by aex on 21.10.2025.
//

import UIKit
import CoreData

enum FilterMode {
    case isFavorite, inCart
}

class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SneakerStore")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private let viewContext: NSManagedObjectContext
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    // MARK: - CRUD
    func addOrUpdate(sneaker: Sneaker, isFavorite: Bool? = nil, inCart: Bool? = nil) {
        let fetchRequest = SneakerCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", sneaker.id)
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            if let sneakerCD = results.first {
                // Обновляем существующую запись
                if let isFavorite = isFavorite {
                    sneakerCD.isFavorite = isFavorite
                }
                if let inCart = inCart {
                    sneakerCD.inCart = inCart
                }
                
                // Если оба флага false, удаляем объект полностью
                if sneakerCD.isFavorite == false && sneakerCD.inCart == false {
                    viewContext.delete(sneakerCD)
                }
            } else {
                // Создаем новую запись если не нашли
                let newSneakerCD = SneakerCD(context: viewContext)
                newSneakerCD.id = sneaker.id
                newSneakerCD.brand = sneaker.brand
                newSneakerCD.sneaker = sneaker.sneaker
                newSneakerCD.price = sneaker.price
                newSneakerCD.sneakerImages = try? JSONEncoder().encode(sneaker.sneakerImages)
                newSneakerCD.isFavorite = isFavorite ?? false
                newSneakerCD.inCart = inCart ?? false
            }
            saveContext()
        } catch {
            print("Error updating or creating sneaker: \(error.localizedDescription)")
        }
    }
    
    func fetchData(filteredBy: FilterMode) -> [Sneaker] {
        let fetchRequest = SneakerCD.fetchRequest()
        
        switch filteredBy {
        case .isFavorite:
            fetchRequest.predicate = NSPredicate(format: "isFavorite == true")
        case .inCart:
            fetchRequest.predicate = NSPredicate(format: "inCart == true")
        }
        
        return fetchData(with: fetchRequest)
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - Private methods
extension StorageManager {
    private func fetchData(with fetchRequest: NSFetchRequest<SneakerCD>) -> [Sneaker] {
        do {
            let sneakersCDs = try viewContext.fetch(fetchRequest)
            
            let sneakers = sneakersCDs.compactMap { item -> Sneaker? in
                guard let id = item.id,
                      let brand = item.brand,
                      let sneaker = item.sneaker,
                      let price = item.price,
                      let imagesData = item.sneakerImages,
                      let sneakerImages = try? JSONDecoder().decode([String].self, from: imagesData)
                else { return nil }
                
                return Sneaker(
                    id: id,
                    brand: brand,
                    sneaker: sneaker,
                    price: price,
                    sizesAvailable: [],
                    sneakerImages: sneakerImages,
                    isFavorite: item.isFavorite
                )
            }
            return sneakers
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
//    func fetchFavorites() -> [Sneaker] {
//        let fetchRequest = SneakerCD.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "isFavorite == true")
//        return fetchData(with: fetchRequest)
//    }
//    
//    func fetchCartItems() -> [Sneaker] {
//        let fetchRequest = SneakerCD.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "inCart == true")
//        return fetchData(with: fetchRequest)
//    }
    
//    private func delete(_ sneaker: Sneaker) {
//        let fetchRequest = SneakerCD.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id == %@", sneaker.id)
//        
//        do {
//            if let objectToDelete = try viewContext.fetch(fetchRequest).first {
//                viewContext.delete(objectToDelete)
//                try viewContext.save()
//            } else {
//                print("Sneaker is not found for id \(sneaker.id)")
//            }
//        } catch {
//            print("Error deleting sneaker: \(error.localizedDescription)")
//        }
//    }
    
//    func create(_ sneaker: Sneaker, isFavorite: Bool = false, inCart: Bool = false) {
//        let item = SneakerCD(context: viewContext)
//        
//        if item.id != sneaker.id {
//            item.id = sneaker.id
//            item.brand = sneaker.brand
//            item.sneaker = sneaker.sneaker
//            item.price = sneaker.price
//            item.sneakerImages = try? JSONEncoder().encode(sneaker.sneakerImages)
//            //item.isFavorite = sneaker.isFavorite
//            
//            item.isFavorite = isFavorite
//            item.inCart = inCart
//            
//            saveContext()
//        }
//    }
    
//    func updateSneakerFlags(for sneaker: Sneaker, isFavorite: Bool? = nil, inCart: Bool? = nil) {
//        let fetchRequest = SneakerCD.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id == %@", sneaker.id)
//        
//        do {
//            if let sneakerCD = try viewContext.fetch(fetchRequest).first {
//                if let isFavorite = isFavorite {
//                    sneakerCD.isFavorite = isFavorite
//                }
//                
//                if let inCart = inCart {
//                    sneakerCD.inCart = inCart
//                }
//                
//                if sneakerCD.isFavorite == false && sneakerCD.inCart == false {
//                    viewContext.delete(sneakerCD)
//                }
//                
//                saveContext()
//            }
//        } catch {
//            print("Error updating sneaker flags or deleting object: \(error.localizedDescription)")
//        }
//    }
}
