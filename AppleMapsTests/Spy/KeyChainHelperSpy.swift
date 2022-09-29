//
//  KeyChainHelperSpy.swift
//  AppleMapsTests
//
//  Created by sergio serrano on 25/9/22.
//

import Foundation
@testable import AppleMaps

class KeyChainHelperSpy: KeyChainHelper {
    
    var saveCalled = false
    var readCalled = false
    var saveDataEqual = false
    
    override init() {}
    
    override func save(data: Data, service: String, account: String) {
        saveCalled = true
        
        guard let response = String(data: data, encoding: .utf8) else {
            return
        }
        saveDataEqual = "123456" == response
    }
    
    override func read(service: String, account: String) -> Data? {
        readCalled = true
        return Data()
    }
    
}
