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
        XCTAssertNoThrow(try URLParameterEncoder().encode(parameters: urlParameters, in: request))
    }
    
    func testURLParameterEncoder2() {
        let request = URLRequest(url: URL(string: "http://sample.com")!)
        let urlParameters = [
            "id": "17",
            "name": "Jon",
            "surname": "Doe"
        ]
        let newRequest = try? URLParameterEncoder().encode(parameters: urlParameters, in: request)
        XCTAssertNotNil(newRequest)
    }
    
    func testURLParameterEncoder3() {
        let request = URLRequest(url: URL(string: "http://sample.com")!)
        let urlParameters = [
            "id": "17",
            "name": "Jon",
            "surname": "Doe"
        ]
        let newRequest = try? URLParameterEncoder().encode(parameters: urlParameters, in: request)
        
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
        let newRequest = try? URLParameterEncoder().encode(parameters: urlParameters, in: request)
        
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
        let newRequest = try? URLParameterEncoder().encode(parameters: urlParameters, in: request)
        
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
    
    func testHeaderParameterEncoder1() {
        let request = URLRequest(url: URL(string: "localhost")!)
        let headerParameters = [
           "Host": "freeuni.edu.ge"
        ]

        XCTAssertNoThrow(try URLParameterEncoder().encode(parameters: headerParameters, in: request))
    }
    
    func testHeaderParameterEncoder2() {
        let request = URLRequest(url: URL(string: "localhost")!)
        let headerParameters = [
            "Host": "freeuni.edu.ge"
        ]

        XCTAssertNotNil(HeaderParameterEncoder().encode(parameters: headerParameters, in: request))
    }
    
    func testHeaderParameterEncoder3() {
        let request = URLRequest(url: URL(string: "localhost")!)
        let headerParameters = [
            "Host": "freeuni.edu.ge",
            "Accept": "text/html",
            "Accept-Encoding": "gzip, deflate"
        ]
        
        let newRequest = HeaderParameterEncoder().encode(parameters: headerParameters, in: request)
        headerParameters.forEach {
             XCTAssert($1 == newRequest.value(forHTTPHeaderField: $0))
        }
    }
    
    func testHeaderParameterEncoder4() {
        let request = URLRequest(url: URL(string: "localhost")!)
        let headerParameters = [
            "Host": "freeuni.edu.ge",
            "X-Forwarded-Host": "en.wikipedia.org",
            "X-Csrf-Token": "i8XNjC4b8KVok4uw53ws32RftR38Wgp2"
        ]
        
        let newRequest = HeaderParameterEncoder().encode(parameters: headerParameters, in: request)
        headerParameters.forEach {
            XCTAssert($1 == newRequest.value(forHTTPHeaderField: $0))
        }
    }
    
    func testURLExpressibleByStringLiteral1() {
        let url: URL = URL(string: "freeuni.edu.ge")!
        let urlLiteral: URL = "freeuni.edu.ge"
        
        XCTAssert(url.absoluteString == urlLiteral.absoluteString)
    }
    
    func testURLExpressibleByStringLiteral2() {
        let url: URL = URL(string: "https://on.ge/story/59808-%E1%83%9B%E1%83%94%E1%83%AA%E1%83%9C%E1%83%98%E1%83%94%E1%83%A0%E1%83%94%E1%83%91%E1%83%98-%E1%83%99%E1%83%9D%E1%83%A0%E1%83%9D%E1%83%9C%E1%83%90%E1%83%95%E1%83%98%E1%83%A0%E1%83%A3%E1%83%A1%E1%83%97%E1%83%90%E1%83%9C-%E1%83%91%E1%83%A0%E1%83%AB%E1%83%9D%E1%83%9A%E1%83%90%E1%83%A8%E1%83%98-%E1%83%9A%E1%83%90%E1%83%9B%E1%83%94%E1%83%91%E1%83%98%E1%83%A1-%E1%83%90%E1%83%9C%E1%83%A2%E1%83%98%E1%83%A1%E1%83%AE%E1%83%94%E1%83%A3%E1%83%94%E1%83%9A%E1%83%91%E1%83%A1-%E1%83%98%E1%83%A7%E1%83%94%E1%83%9C%E1%83%94%E1%83%91%E1%83%94%E1%83%9C-%E1%83%99%E1%83%95%E1%83%9A%E1%83%94%E1%83%95%E1%83%90")!
        let urlLiteral: URL = "https://on.ge/story/59808-%E1%83%9B%E1%83%94%E1%83%AA%E1%83%9C%E1%83%98%E1%83%94%E1%83%A0%E1%83%94%E1%83%91%E1%83%98-%E1%83%99%E1%83%9D%E1%83%A0%E1%83%9D%E1%83%9C%E1%83%90%E1%83%95%E1%83%98%E1%83%A0%E1%83%A3%E1%83%A1%E1%83%97%E1%83%90%E1%83%9C-%E1%83%91%E1%83%A0%E1%83%AB%E1%83%9D%E1%83%9A%E1%83%90%E1%83%A8%E1%83%98-%E1%83%9A%E1%83%90%E1%83%9B%E1%83%94%E1%83%91%E1%83%98%E1%83%A1-%E1%83%90%E1%83%9C%E1%83%A2%E1%83%98%E1%83%A1%E1%83%AE%E1%83%94%E1%83%A3%E1%83%94%E1%83%9A%E1%83%91%E1%83%A1-%E1%83%98%E1%83%A7%E1%83%94%E1%83%9C%E1%83%94%E1%83%91%E1%83%94%E1%83%9C-%E1%83%99%E1%83%95%E1%83%9A%E1%83%94%E1%83%95%E1%83%90"
        
        XCTAssert(url.absoluteString == urlLiteral.absoluteString)
    }
    
    func testURLExpressibleByStringLiteral3() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "github.com"
        urlComponents.path = "/search/repositories"
        let urlLiteral: URL = "https://github.com/search/repositories"

        XCTAssert(urlComponents.url?.absoluteString == urlLiteral.absoluteString)
    }
    
    func testURLExpressibleByStringLiteral4() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "github.com"
        urlComponents.path = "/search/repositories"
        let urlLiteral: URL = "http://github.com/search/repositories"

        XCTAssert(urlComponents.url?.absoluteString == urlLiteral.absoluteString)
    }
    
    func testURLExpressibleByStringLiteral5() {
        let searchTerm = "hello+there"
        let format = "general+kenobi"

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "example.com"
        urlComponents.path = "/ex"
        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: searchTerm),
            URLQueryItem(name: "person", value: format)
        ]
        
        let urlLiteral: URL = "https://example.com/ex?query=hello+there&person=general+kenobi"

        XCTAssert(urlComponents.url?.absoluteString == urlLiteral.absoluteString)
    }
    
    func testJSONEncode1() {
        let request = URLRequest(url: URL(string: "localhost")!)
        let jsonEncoder = JSONParameterEncoder()
        
        let parameters: Parameters = ["id" : "1337"]
        XCTAssertNoThrow(try jsonEncoder.encode(parameters: parameters, in: request))
        XCTAssertEqual(try! JSONDecoder().decode(Parameters.self, from: (try! jsonEncoder.encode(parameters: parameters, in: request)).httpBody!), parameters)
    }
    
    func testJSONEncode2() {
        let request = URLRequest(url: URL(string: "localhost")!)
        let jsonEncoder = JSONParameterEncoder()
        
        let parameters: Parameters = [
            "username" : "general_kenobi",
            "first_name" : "Obi-Wan",
            "last_name" : "Kenobi"
        ]
        
        XCTAssertNoThrow(try jsonEncoder.encode(parameters: parameters, in: request))
        let newRequest = try! jsonEncoder.encode(parameters: parameters, in: request)
        let decodedResult = try! JSONDecoder().decode(Parameters.self, from: newRequest.httpBody!)
        XCTAssertEqual(decodedResult, parameters)
    }
    
    func testJSONEncode3() {
        let request = URLRequest(url: URL(string: "localhost")!)
        let jsonEncoder = JSONParameterEncoder()

        let parameters: Parameters = [
           "პირადი_ნომერი" : "1337",
        ]

        XCTAssertNoThrow(try jsonEncoder.encode(parameters: parameters, in: request))
        let newRequest = try! jsonEncoder.encode(parameters: parameters, in: request)
        let decodedResult = try! JSONDecoder().decode(Parameters.self, from: newRequest.httpBody!)
        XCTAssertEqual(decodedResult, parameters)
    }
    
    func testJSONEncode4() {
        let request = URLRequest(url: URL(string: "localhost")!)
        let jsonEncoder = JSONParameterEncoder()
           
        let parameters: Parameters = [:]
           
        XCTAssertNoThrow(try jsonEncoder.encode(parameters: parameters, in: request))
        XCTAssertEqual(request, try! jsonEncoder.encode(parameters: parameters, in: request))
    }
}
