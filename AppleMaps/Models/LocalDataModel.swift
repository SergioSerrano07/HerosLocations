//
//  LocalDataModel.swift
//  AppleMaps
//
//  Created by sergio serrano on 29/9/22.
//

import Foundation

final class LocalDataModel {
    
    private static let userDefaults = UserDefaults.standard
    
    static func saveSyncDate() {
        userDefaults.set(Date(), forKey: "KCLastSyncDate")
    }
    
    static func staticSyncDate() -> Date? {
        userDefaults.object(forKey: "KCLastSyncDate") as? Date
    }
    
    
    
}
