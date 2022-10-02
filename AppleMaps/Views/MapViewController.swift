//
//  ViewController.swift
//  AppleMaps
//
//  Created by sergio serrano on 13/9/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    //MARK: - IBOutlet
    
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Constants
    
    let viewModel = MapViewModel()
    
    private var heroLocations: [HeroCordinates] = []
    
    var hero: HeroService?
    
    //MARK: - Cicle of life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.loadLocations()
            }
        }
        
        viewModel.viewDidLoad()
        
    }
    
    func set(model: [HeroCordinates]) {
        self.heroLocations = model
    }
    
    
    func loadLocations() {
        setupMap()
        guard let hero = hero else { return }
        viewModel.getHeroesAnnotations(name: hero.name, locations: heroLocations) { arrayAnnotations in
            mapView.addAnnotations(arrayAnnotations)
        }
    }

    //MARK: Configuration
    
    func setupMap() {
        mapView.showsUserLocation = true
        mapView.centerToLocation(location: CLLocation(latitude: 40.41, longitude: -3.70))
    }
}


