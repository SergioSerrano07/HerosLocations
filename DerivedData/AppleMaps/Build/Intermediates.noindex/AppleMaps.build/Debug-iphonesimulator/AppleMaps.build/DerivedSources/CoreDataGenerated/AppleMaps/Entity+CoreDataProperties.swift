//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by sergio serrano on 2/10/22.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }


}

extension Entity : Identifiable {

}
