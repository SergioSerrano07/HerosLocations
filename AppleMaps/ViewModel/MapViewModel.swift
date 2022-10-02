//
//  ViewModel.swift
//  AppleMaps
//
//  Created by sergio serrano on 13/9/22.
//

import Foundation
import CoreLocation
import KeychainSwift
import MapKit


final class MapViewModel {
    // Creamos
    //MARK: Constants
    private let networkModel: NetworkModel
    private let locationManager: CLLocationManager
    private var keychain: KeychainSwift
    private var coreDataManager: CoreDataManager

    var onSuccess: (() -> Void)?
    
    init(networkModel: NetworkModel = NetworkModel(),
         locationManager: CLLocationManager = CLLocationManager(),
         keychain: KeychainSwift = KeychainSwift(),
         coreDataManager: CoreDataManager = .shared,
         onSuccess: ( () -> Void)? = nil) {
        self.networkModel = networkModel
        self.locationManager = locationManager
        self.keychain = keychain
        self.coreDataManager = coreDataManager
        self.onSuccess = onSuccess
    }
    
    //MARK: Variables
    var heroes: [HeroService] = []
    
    //MARK: Cycle of Life
    func viewDidLoad() {
        checkLocationServices()
        checkLocationAuthorization()
        
        onSuccess?()
    }
        

    //MARK: MapKit
    func getHeroesAnnotations(name: String, locations: [HeroCordinates], completion: ([MKPointAnnotation]) -> Void) {
        
        var annotationsArray: [ MKPointAnnotation ] = []
//        getHeroesCoreData()
        
        for location in locations {
            let annotations = MKPointAnnotation()
            annotations.title = name
            annotations.coordinate = CLLocationCoordinate2D(latitude: Double(location.latitud) ?? 0.0 , longitude: Double(location.longitud) ?? 0.0)
            annotationsArray.append(annotations)
            print(annotations)
        }
        completion(annotationsArray)
    }
    
    //MARK: Locations
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled(){
            checkLocationAuthorization()
        } else {
            print("Location services are not enabled")
            }
        }
        
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            print("No access")
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            print("Access")
//            mapView.showsUserLocation = true
        @unknown default:
            break
           }
    }
}
