//
//  HeroLocations+CoreDataClass.swift
//  AppleMaps
//
//  Created by sergio serrano on 30/9/22.
//
//

import Foundation
import CoreData

@objc(HeroLocations)
public class HeroLocations: NSManagedObject {

}

extension HeroLocations {
    static func create(from location: HeroCordinates, for hero: HeroServices, context: NSManagedObjectContext) -> HeroLocations {
        
        let heroLocations = HeroLocations(context: context)
        heroLocations.id = location.id
        heroLocations.latitud = location.latitud
        heroLocations.longitud = location.longitud
        heroLocations.hero = hero
        
        return heroLocations
    }
    
    var location: HeroCordinates {
        HeroCordinates(latitud: self.latitud,
                       longitud: self.longitud,
                       id: self.id)
    }
}
