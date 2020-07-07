//
//  GatewayTests.swift
//  GatewayTests
//
//  Created by Vato Kostava on 7/5/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import XCTest
@testable import Gateway

class GatewayTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testURLParameterEncoder1() {
        let request = URLRequest(url: URL(string: "http://sample.com")!)
        let urlParameters = [
            "id": "17",
            "name": "Jon",
            "surname": "Doe"
        ]
        XCTAssertNoThrow(try URLParameterEncoder.encode(parameters: urlParameters, in: request))
    }
    
    func testURLParameterEncoder2() {
        let request = URLRequest(url: URL(string: "http://sample.com")!)
        let urlParameters = [
            "id": "17",
            "name": "Jon",
            "surname": "Doe"
        ]
        let newRequest = try? URLParameterEncoder.encode(parameters: urlParameters, in: request)
        XCTAssertNotNil(newRequest)
    }
    
    func testURLParameterEncoder3() {
        let request = URLRequest(url: URL(string: "http://sample.com")!)
        let urlParameters = [
            "id": "17",
            "name": "Jon",
            "surname": "Doe"
        ]
        let newRequest = try? URLParameterEncoder.encode(parameters: urlParameters, in: request)
        
        guard let url = newRequest?.url else {
            XCTAssert(true)
            return
        }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        XCTAssertNotNil(urlComponents)
        var decodedParameters = [String: String]()
        urlComponents!.queryItems?.forEach({ item in
            decodedParameters[item.name] = item.value?.removingPercentEncoding
        })
        
        XCTAssert(urlParameters == decodedParameters)
    }
    
    func testURLParameterEncoder4() {
        let request = URLRequest(url: URL(string: "http://sample.com")!)
        let urlParameters = [String: String]()
        let newRequest = try? URLParameterEncoder.encode(parameters: urlParameters, in: request)
        
        guard let url = newRequest?.url else {
            XCTAssert(true)
            return
        }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        XCTAssertNotNil(urlComponents)
        XCTAssertNil(urlComponents!.queryItems)
    }
    
    func testURLParameterEncoder5() {
        let request = URLRequest(url: URL(string: "http://sample.com")!)
        let urlParameters = [
            "id": "17",
            "name": "Jonathan William",
            "surname": "O'Henry Busta"
        ]
        let newRequest = try? URLParameterEncoder.encode(parameters: urlParameters, in: request)
        
        guard let url = newRequest?.url else {
            XCTAssert(true)
            return
        }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        XCTAssertNotNil(urlComponents)
        var decodedParameters = [String: String]()
        urlComponents!.queryItems?.forEach({ item in
            decodedParameters[item.name] = item.value?.removingPercentEncoding
        })
        
        XCTAssert(urlParameters == decodedParameters)
        XCTAssert(newRequest?.value(forHTTPHeaderField: ContentType.header) == ContentType.urlEncoded.rawValue)
    }

}
