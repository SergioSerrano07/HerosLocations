//
//  HeroLocations+CoreDataProperties.swift
//  AppleMaps
//
//  Created by sergio serrano on 30/9/22.
//
//

import Foundation
import CoreData


extension HeroLocations {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<HeroLocations> {
        return NSFetchRequest<HeroLocations>(entityName: "HeroLocations")
    }

    @NSManaged public var id: String
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var hero: HeroServices

}

extension HeroLocations : Identifiable {

}
