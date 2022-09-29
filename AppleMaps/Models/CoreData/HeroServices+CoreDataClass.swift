//
//  HeroServices+CoreDataClass.swift
//  AppleMaps
//
//  Created by sergio serrano on 29/9/22.
//

import Foundation
import CoreData

@objc(HeroServices)
public class HeroServices: NSManagedObject {

}

extension HeroServices {
    static func create(from hero: HeroServices, context: NSManagedObjectContext) -> HeroServices {
        
        let cdHero = HeroServices(context: context)
        cdHero.id = hero.id
        cdHero.name = hero.name
        cdHero.favorite = hero.favorite
        cdHero.heroDescription = hero.description
        cdHero.photoUrl = hero.photo
        
        return cdHero
    }
    
    var hero: HeroServices {
        Hero(photo: self.photoUrl,
             id: self.id,
             favorite: self.favorite,
             name: self.name,
             description: self.heroDescription)
    }
}
