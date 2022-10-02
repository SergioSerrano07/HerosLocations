//
//  CoreDataManager.swift
//  AppleMaps
//
//  Created by sergio serrano on 14/9/22.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AppleMaps")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()

    static let shared = CoreDataManager()
    
    func fetchHeros() -> [HeroServices] {
        let request = HeroServices.createFetchRequest()
        
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print("Error getting heroes")
        }
        
        return []
    }
    
    func fetchHero(id heroId: String) -> HeroServices? {
        let request = HeroServices.createFetchRequest()
        let predicate = NSPredicate(format: "id == %@", heroId)
        request.predicate = predicate
        request.fetchBatchSize = 1
        
        do {
            let result = try context.fetch(request)
            return result.first
        } catch {
            print("Error getting heroes")
        }
        
        return nil
    }
    
    func fetchLocations(for heroID: String) -> [HeroLocations] {
        let request = HeroLocations.createFetchRequest()
        let predicate = NSPredicate(format: "hero.id == %@", heroID)
        request.predicate = predicate
        
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print("Error getting locations")
        }
        return []
    }
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        context.saveContext()
    }
    
    func deleteAll() {
        let cdHeros = fetchHeros()
        cdHeros.forEach{context.delete($0)}
        saveContext()
    }
}

extension NSManagedObjectContext {
    func saveContext() {
        guard hasChanges else { return }
        do {
            try save()
        } catch {
            fatalError("Error: \(error.localizedDescription) ")
        }
    }
}


