//
//  HeroServices+CoreDataProperties.swift
//  AppleMaps
//
//  Created by sergio serrano on 2/10/22.
//
//

import Foundation
import CoreData


extension HeroServices {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HeroServices> {
        return NSFetchRequest<HeroServices>(entityName: "HeroServices")
    }

    @NSManaged public var favorite: Bool
    @NSManaged public var heroDescription: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var photoURL: URL?
    @NSManaged public var location: NSSet?

}

// MARK: Generated accessors for location
extension HeroServices {

    @objc(addLocationObject:)
    @NSManaged public func addToLocation(_ value: HeroLocations)

    @objc(removeLocationObject:)
    @NSManaged public func removeFromLocation(_ value: HeroLocations)

    @objc(addLocation:)
    @NSManaged public func addToLocation(_ values: NSSet)

    @objc(removeLocation:)
    @NSManaged public func removeFromLocation(_ values: NSSet)

}

extension HeroServices : Identifiable {

}
