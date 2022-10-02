//
//  NetworkModelTests.swift
//  PracticaFundamentosiOSTests
//
//  Created by Roberto Rojo Sahuquillo on 16/9/22.
//

import XCTest

@testable import AppleMaps

enum ErrorMock: Error {
    case mockCase
}

final class NetworkModelTests: XCTestCase {
    private var urlSessionMock: URLSessionMock!
    //sut -> System under testing
    private var sut: NetworkModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        urlSessionMock = URLSessionMock()
        sut = NetworkModel(urlSession: urlSessionMock)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testLoginFailWithNoData() {
        //Given
        var error: NetworkError?
        
        urlSessionMock.data = nil
        
        //When
        sut.login(user: "", password: "") { _, networkError in
            error = networkError
        }
        
        //Then
        XCTAssertEqual(error, .noData)
    }
    
    func testLoginFailWithError() {
            //Given
            var error: NetworkError?
            
            urlSessionMock.data = nil
            urlSessionMock.error = ErrorMock.mockCase
            
            //When
            sut.login(user: "", password: "") { _, networkError in
                error = networkError
            }
        
            //Then
            XCTAssertEqual(error, .other)
        }
    
    
    func testLoginFailWithErrorCodeNil() {
            //Given
            var error: NetworkError?
            
            urlSessionMock.data = "TokenString".data(using: .utf8)!
            urlSessionMock.response = nil
            
            //When
            sut.login(user: "", password: "") { _, networkError in
                error = networkError
            }
        
            //Then
            XCTAssertEqual(error, .errorCode(nil))
        }
    
    func testLoginFailWithErrorCode() {
            //Given
            var error: NetworkError?
            
            urlSessionMock.data = "TokenString".data(using: .utf8)!
            urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 404, httpVersion: nil, headerFields: nil)
            
            //When
            sut.login(user: "", password: "") { _, networkError in
                error = networkError
            }
        
            //Then
            XCTAssertEqual(error, .errorCode(404))
        }
    
    
        
    func testLoginSuccessWithMockToken() throws {
        //Given
        var retrievedToken: String?
        var error: NetworkError?
        
        urlSessionMock.data = "TokenString".data(using: .utf8)!
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        //When
        sut.login(user: "", password: "") { token, networkError in
            retrievedToken = token
            error = networkError
        }

        //Then
        XCTAssertNotNil(retrievedToken, "Should have received a token")
        XCTAssertNil(error, "Should no be an error")
    }

    func testGetHeroesSuccess() {
    
        var retrievedHeroes: [HeroService]?
        var error: NetworkError?
        
        //Given
        sut.token = "TokenString"
        urlSessionMock.data = getHeroesData(resourceName: "heroes")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        //When
        sut.getHeroes { heroes, networkErrror in
            retrievedHeroes = heroes
            error = networkErrror
        }
        
        //Then
        XCTAssertNotNil(urlSessionMock.data)
        XCTAssertTrue(retrievedHeroes?.count ?? 0 > 0, "Should have received heroes")
        XCTAssertNil(error, "Should no be an error")
        }
    
    
    func testGetHerosSuccessWithNoHeroes() {
        var error: NetworkError?
        var retrievedHeroes: [HeroService]?
        
        //Given
        sut.token = "testToken"
        urlSessionMock.data = getHeroesData(resourceName: "noHeroes")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        sut.getHeroes { heroes, networkError in
            error = networkError
            retrievedHeroes = heroes
        }
        
        //Then
        XCTAssertNotNil(retrievedHeroes)
        XCTAssertEqual(retrievedHeroes?.count, 0)
        XCTAssertNil(error, "there should be no error")
    }

    func testGetLocationsSuccess() {
        
        var retrievedLocations: [HeroCordinates]?
        var error: NetworkError?
        
        //Given
        sut.token = "TokenString"
        urlSessionMock.data = getLocationsData(resourceName: "locations")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        sut.getLocalizationHero(id: "14BB8E98-6586-4EA7-B4D7-35D6A63F5AA3") { locations, networkError in
            retrievedLocations = locations
            error = networkError
            
        }
            //Then
            XCTAssertNotNil(urlSessionMock.data)
            XCTAssertTrue(retrievedLocations?.count ?? 0 > 0, "Should have received transformations")
            XCTAssertNil(error, "Should no be an error")
        }
    
    func testGetLocationsSuccessWithNoTransformations() {
        var error: NetworkError?
        var retrievedLocations: [HeroCordinates]?
        
        //Given
        sut.token = "testToken"
        urlSessionMock.data = getLocationsData(resourceName: "noLocations")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        sut.getLocalizationHero(id: "14BB8E98-6586-4EA7-B4D7-35D6A63F5AA3") { locations, networkError in
            error = networkError
            retrievedLocations = locations
        }
        
        //Then
        XCTAssertNotNil(retrievedLocations)
        XCTAssertEqual(retrievedLocations?.count, 0)
        XCTAssertNil(error, "there should be no error")
    }
}

extension NetworkModelTests {
    
    func getHeroesData(resourceName: String) -> Data? {
        
        let bundle = Bundle(for: NetworkModelTests.self)
        
        guard let path = bundle.path(forResource: resourceName, ofType: "json") else { return nil}
        
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
    
    func getLocationsData(resourceName: String) -> Data? {
        
        let bundle = Bundle(for: NetworkModelTests.self)
        
        guard let path = bundle.path(forResource: resourceName, ofType: "json") else { return nil}
        
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
}
