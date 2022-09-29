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
        
        guard !cdHeros.isEmpty else {
            print("Heroes Network Call")
            guard let token = keyChain.get("KCToken") else { return }
            networkModel.token = token
             
            networkModel.getHeroes { [weak self] heros, error in
                self?.content = heros
                self?.onSuccess?()
                self?.save(heroes: heros)
            }
            return
        }

        
        print("Heroes from Core Data")
        content = cdHeros.map{ $0.hero }
        onSuccess?()
    }
}

private extension TableViewModel {
    func save(heroes: [HeroService]) {
        _ = heroes.map { HeroServices.create(from: $0,
                                       context: coreDataManager.context) }
        coreDataManager.saveContext()
    }
}
