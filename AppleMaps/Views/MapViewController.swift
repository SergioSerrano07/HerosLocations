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
    
    private var model: ModelDisplayable?
    
    //MARK: - Cicle of life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let model = model else {
            return
        }
        
        navigationController?.navigationBar.isHidden = false
        mapView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.checkLocationsServices()
        viewModel.viewWillAppear()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMap()
        viewModel.getHeroesAnnotations { arrayAnnotations in
            mapView.addAnnotations(arrayAnnotations)
        }
    }
    
    func set(model: HeroService) {
        self.model = model
    }

    //MARK: Configuration
    
    func setupMap() {
        mapView.showsUserLocation = true
        mapView.centerToLocation(location: CLLocation(latitude: 40.41, longitude: -3.70))
    }
}


