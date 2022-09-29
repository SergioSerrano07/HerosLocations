//
//  HeroServices+CoreDataProperties.swift
//  AppleMaps
//
//  Created by sergio serrano on 29/9/22.
//

import Foundation
import CoreData


extension HeroServices {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<HeroServices> {
        return NSFetchRequest<HeroServices>(entityName: "HeroServices")
    }

    @NSManaged public var heroDescription: String
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var favorite: Bool
    @NSManaged public var photoUrl: URL
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

extension HeroServices : Identifiable {

}
