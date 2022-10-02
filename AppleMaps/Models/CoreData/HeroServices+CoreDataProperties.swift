//
//  HeroServices+CoreDataProperties.swift
//  AppleMaps
//
//  Created by sergio serrano on 30/9/22.
//
//

import Foundation
import CoreData


extension HeroServices {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<HeroServices> {
        return NSFetchRequest<HeroServices>(entityName: "HeroServices")
    }

    @NSManaged public var favorite: Bool
    @NSManaged public var heroDescription: String
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var photoURL: URL
    @NSManaged public var location: NSSet?

}

extension HeroServices {
    @objc(addHeroLocationsObject:)
    @NSManaged public func addToLocations(_ value: HeroLocations)
    
    @objc(removeHeroLocationsObject:)
    @NSManaged public func removeFromLocations(_ value: HeroLocations)
    
    @objc(addHeroLocations:)
    @NSManaged public func addToLocations(_ values: NSSet)
    
    @objc(removeHeroLocations:)
    @NSManaged public func removeFromLocations(_ values: NSSet)
    
}

extension HeroServices: Identifiable {
    
}
