//
//  LoginViewModel.swift
//  AppleMapsTests
//
//  Created by sergio serrano on 21/9/22.
//

import XCTest
@testable import AppleMaps

class LoginViewModelTest: XCTestCase {

    func testLoginServiceTokenSuccess() {
        let network = NetworkModelSpy()
        let sut = LoginViewModel(network: network)
        
        sut.callLoginService(user: "Ivan", password: "") { token, error in
            XCTAssertTrue(network.loginCalled)
            XCTAssertEqual(token, "123456")
            XCTAssertNil(nil)
        }
    }
    
    func testcallLoginServiceMalformedUrl() {
        let network = NetworkModelSpy()
        let sut = LoginViewModel(network: network)
        
        sut.callLoginService(user: "Salvador", password: "") { token, error in
            XCTAssertTrue(network.loginCalled) 
            XCTAssertNil(token)
        }
    }
    
    func testSaveToken() {
        let keyChain = KeyChainHelperSpy()
        let sut = LoginViewModel(keyChain: keyChain)
        
        sut.saveToken(token: "")
        XCTAssertTrue(keyChain.saveCalled)
    }
    
    func testSaveTokenSaveCalledTokenSaveSuccess() {
        let keyChain = KeyChainHelperSpy()
         let sut = LoginViewModel(keyChain: keyChain)
        
        sut.saveToken(token: "123456")
        XCTAssertTrue(keyChain.saveCalled)
        XCTAssertTrue(keyChain.saveDataEqual)
    }
}
