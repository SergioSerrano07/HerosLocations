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
        let container = NSPersistentContainer(name: "HeroServices")
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
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        context.saveContext()
    }
    
    func deleteAll() {
        //Delete objects
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


