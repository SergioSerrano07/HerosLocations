//
//  HeroService.swift
//  AppleMaps
//
//  Created by sergio serrano on 13/9/22.
//

import Foundation


struct HeroService: ModelDisplayable, Decodable {
    let photo: URL
    let name: String
    let favorite: Bool
    let id: String
    let description: String
}
