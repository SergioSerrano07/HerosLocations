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
    static func create(from location: HeroCordinates, for hero: HeroServices ,context: NSManagedObjectContext) -> HeroLocations {
        
        let heroLocations = HeroLocations(context: context)
        heroLocations.id = location.id
        heroLocations.latitude = location.latitude ?? 0.0
        heroLocations.longitude = location.longitude ?? 0.0
        heroLocations.hero = hero
        
        return heroLocations
    }
    
    var location: HeroCordinates {
        HeroCordinates(latitude: self.latitude,
                       longitude: self.longitude,
                       id: self.id)
    }
}
