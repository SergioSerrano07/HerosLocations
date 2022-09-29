//
//  ViewModel.swift
//  AppleMaps
//
//  Created by sergio serrano on 13/9/22.
//

import Foundation
import MapKit
import KeychainSwift

final class MapViewModel {
    
    //MARK: - Constants
    private let coreDataManager = CoreDataManager()
    private let manager = CLLocationManager()
    private let keyChain = KeychainSwift()
    
    //MARK: - Variables
    
    private var network = NetworkModel()
    var hero: [HeroServices] = []
    var heroService: [HeroService] = []
    
    //MARK: - Cicle of life
    func viewWillAppear() {
        
        guard let token = keyChain.get("KCToken") else { return } 
            print("Aquí está nuestro token: \(token)")
            self.network = NetworkModel(token: token)
        
         
        self.network.getHeroes { heroes, error in
            //notifications
        }
    }

//    func getCordinates() {
//        for (ind, heroe) in heroService.enumerated() {
//            self.network.getLocalizationHero(id: heroe.id) { [self] cordinateArray, error in
//                if cordinateArray.count > 0 {
//                    let cordinate = cordinateArray.first
//                    self.heroService[ind].latitude = cordinate?.latitude ?? 0.0
//                    self.heroService[ind].longitude = cordinate?.longitude ?? 0.0
//                }
//            }
//        }
//    }
    
    
    //MARK: getHeroes for CoreData
    
    func getHeroesForCoreData() {
        hero = self.coreDataManager.fetchHeros()
    }
    
    //MARK: Mapkit
    func getHeroesAnnotations(completion: ([MKPointAnnotation]) -> Void) {
        var annotationsArray: [MKPointAnnotation] = []
        getHeroesForCoreData()
        
        for hero in hero {
            let annotations = MKPointAnnotation()
            annotations.title = hero.name
            annotations.coordinate = CLLocationCoordinate2D(latitude: Double(hero.latitude), longitude: Double(hero.longitude))
            annotationsArray.append(annotations)
        }
        completion(annotationsArray)
    }
    
    
    
    //MARK: - Locations
    
    func checkLocationsServices() {
        if CLLocationManager.locationServicesEnabled() {
            
            checkLocationAuthorization()
            
        } else {
            //Errors
            
        }
    }
    
    private func checkLocationAuthorization() {
        manager.requestAlwaysAuthorization()
    }
}
