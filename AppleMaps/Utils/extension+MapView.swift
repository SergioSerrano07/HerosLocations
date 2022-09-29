//
//  Extension+MapView.swift
//  AppleMaps
//
//  Created by sergio serrano on 13/9/22.
//

import Foundation
import MapKit

extension MKMapView {
    func centerToLocation(location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        
        self.setRegion(coordinateRegion, animated: true)
        
    }
}
