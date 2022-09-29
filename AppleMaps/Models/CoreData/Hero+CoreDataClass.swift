//
//  Hero+CoreDataClass.swift
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
    static func create(from hero: HeroService, context: NSManagedObjectContext) -> HeroServices {
        
        let cdHero = HeroServices(context: context)
        cdHero.id = hero.id
        cdHero.name = hero.name
        cdHero.favorite = hero.favorite
        cdHero.heroDescription = hero.description
        cdHero.photoUrl = hero.photo
        cdHero.longitude = hero.longitude
        cdHero.latitude = hero.latitude
        
        
        return cdHero
    }
    
    var hero: HeroService {
        HeroService(longitude: self.longitude,
                    latitude: self.latitude,
                    photo: self.photoUrl,
                    name: self.name,
                    favorite: self.favorite,
                    id: self.id,
                    description: self.description)
                    
    }
}