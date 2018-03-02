//
//  URLRequestConvertorTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-03-01.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

class URLRequestConvertorTests: XCTestCase {
    
    struct MockURLConvertor: URLConvertable {
        func makeURL(_ apiRequest: APIRequestable) throws -> URL {
            return URL(string: apiRequest.url)!
        }
    }
    
    func testURLRequestConvertorMakingURLRequestWithAPIRequest() {
        HTTPMethod.allMethods.forEach { method in
            let apiRequest = MockAPIRequest(method: method)
            let serialization = MockSerialization()
            let urlRequestConvertor = URLRequestConvertor(serialization: MockSerialization(),
                                                          urlConvertor: MockURLConvertor())
            let urlRequest = try! urlRequestConvertor.makeURLRequest(apiRequest)
            XCTAssertEqual(urlRequest.url!.absoluteString, apiRequest.url)
            XCTAssertEqual(urlRequest.allHTTPHeaderFields!, serialization.httpHeaders)
            XCTAssertEqual(urlRequest.httpMethod, apiRequest.method.string)
            XCTAssertEqual(urlRequest.timeoutInterval, apiRequest.timeoutInterval)
            XCTAssertNil(urlRequest.httpBody)
        }
    }
    
    func testURLRequestConvertorMakingURLRequestWithNonInlineAPIRequestAndParameters() {
        HTTPMethod.nonInlineMethods.forEach { method in
            let apiRequest = MockAPIRequest(method: method, parameters: ["key": "test"])
            let serialization = MockSerialization()
            let urlRequestConvertor = URLRequestConvertor(serialization: serialization,
                                                          urlConvertor: MockURLConvertor())
            XCTAssertNoThrow(try! urlRequestConvertor.makeURLRequest(apiRequest))
            XCTAssertTrue(serialization.isEncode)
        }
    }
    
    

    
    
}
