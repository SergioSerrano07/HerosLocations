//
//  NetworkModelSpy.swift
//  AppleMapsTests
//
//  Created by sergio serrano on 21/9/22.
//

import Foundation
@testable import AppleMaps

class NetworkModelSpy: NetworkModel {
    
    var loginCalled = false
    
    override func login(user: String, password: String, completion: ((String?, Error?) -> Void)? = nil) {
        loginCalled = true
        if user == "Ivan" {
            completion?("123456", nil)
            return
        }
        
        if user == "Salvador" {
            completion?(nil, NetworkError.malformedURL)
        }
        
        completion?(nil, nil)
    }
}
