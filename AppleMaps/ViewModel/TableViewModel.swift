//
//  TableViewModel.swift
//  AppleMaps
//
//  Created by sergio serrano on 29/9/22.
//

import Foundation
import KeychainSwift

final class TableViewModel {
    private var networkModel: NetworkModel
    private var keyChain: KeychainSwift
    private var coreDataManager: CoreDataManager

    private(set) var content: [HeroService] = []
    
    var onError: ((String) -> Void)?
    var onSuccess: (() -> Void)?
    
    init(networkModel: NetworkModel = NetworkModel(),
         keyChain: KeychainSwift = KeychainSwift(),
         coreDataManager: CoreDataManager = .shared,
         onError: ((String) -> Void)? = nil,
         onSuccess: (() -> Void)? = nil) {
        
        self.keyChain = keyChain
        self.networkModel = networkModel
        self.coreDataManager = coreDataManager
        self.onSuccess = onSuccess
        self.onError = onError
        
    }
    
    func viewDidLoad() {
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.loadHeroes()
        }
    }
    
    func loadHeroes() {
        let cdHeros = coreDataManager.fetchHeros()
        
        guard let date = LocalDataModel.staticSyncDate(),
              date.addingTimeInterval(1) > Date(),
              !cdHeros.isEmpty else {
            
            print("Heroes Network Call")
            guard let token = keyChain.get("KCToken") else { return }
            networkModel.token = token
            
            networkModel.getHeroes { [weak self] heros, error in
                
                if let error = error {
                    self?.onError?("Heroes \(error.localizedDescription)")
                } else {
                    self?.save(heroes: heros)
                    
                    let group = DispatchGroup()
                    
                    heros.forEach { hero in
                        group.enter()
                        self?.downloadLocations(for: hero) {
                            group.leave()
                        }
                    }
                    
                    group.notify(queue: DispatchQueue.global()) {
                        LocalDataModel.saveSyncDate()
                        if let heroServices = self?.coreDataManager.fetchHeros() {
                            self?.content = heroServices.map { $0.hero }
                            
                        }
                        self?.onSuccess?()
                    }
                }
            }
            return
        }
        print("Heroes from Core Data")
        content = cdHeros.map{ $0.hero }
        onSuccess?()
    }
    
    func downloadLocations(for hero: HeroService, completion: @escaping () -> Void) {
        let heroLocations = CoreDataManager.shared.fetchLocations(for: hero.id)
        if heroLocations.isEmpty {
            print("Locations Network Call")
            guard let token = keyChain.get("KCToken") else {
                
                completion()
                return
                
            }
            
            networkModel.token = token
            networkModel.getLocalizationHero(for: hero) { [weak self] locations, error in
                if let error = error {
                    self?.onError?("Error: \(error.localizedDescription)")
                } else {
                    self?.save(locations: locations, for: hero)
                }
                completion()
            }
        } else {
            completion()
        }
    }
}

private extension TableViewModel {
    func save(heroes: [HeroService]) {
        _ = heroes.map { HeroServices.create(from: $0,
                                       context: coreDataManager.context) }
        coreDataManager.saveContext()
    }
    
    func save(locations: [HeroCordinates], for hero: HeroService) {
        guard let heroServices = coreDataManager.fetchHero(id: hero.id) else { return }
        
        _ = locations.map { HeroLocations.create(from: $0, for: heroServices, context: coreDataManager.context) }
        coreDataManager.saveContext()
    }
}
