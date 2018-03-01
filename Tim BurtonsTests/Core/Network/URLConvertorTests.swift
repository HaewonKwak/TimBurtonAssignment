//
//  URLConvertorTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

class URLConvertorTests: XCTestCase {
        
    let urlConvertor = URLConvertor()
    
    func testURLConvertorQueryStringWithNil() {
        let queryString = urlConvertor.convertToQueryString(fromParameters: nil)
        XCTAssertTrue(queryString.isEmpty)
    }
    
    func testURLConvertorQueryStringWithEmpty() {
        let queryString = urlConvertor.convertToQueryString(fromParameters: [:])
        XCTAssertTrue(queryString.isEmpty)
    }

    func testURLConvertorQueryStringWithBool() {
        
        zip([true, false], ["isPass=1", "isPass=0"]).forEach { bool, string in
            let queryString = urlConvertor.convertToQueryString(fromParameters: ["isPass": bool])
            XCTAssertEqual(queryString, string)
        }
    }
    
    func testURLConvertorQueryStringWithInt() {
        let queryString = urlConvertor.convertToQueryString(fromParameters: ["number": 1])
        XCTAssertEqual(queryString, "number=1")
    }

    func testURLConvertorQueryStringWithDouble() {
        let queryString = urlConvertor.convertToQueryString(fromParameters: ["price": 1.2])
        XCTAssertEqual(queryString, "price=1.2")
    }
    
    func testURLConvertorQueryStringWithString() {
        let queryString = urlConvertor.convertToQueryString(fromParameters: ["value": "test"])
        XCTAssertEqual(queryString, "value=test")
    }

    func testURLConvertorQueryStringWithArray() {
        let queryString = urlConvertor.convertToQueryString(fromParameters: ["values": ["test1", "test2", "test3"]])
        XCTAssertEqual(queryString, "values=test1,test2,test3")
    }
    
    func testURLConvertorQueryStringWithMultipleParameters() {
        let queryString = urlConvertor.convertToQueryString(fromParameters: ["price": 1.2, "values": ["test1", "test2", "test3"]])
        XCTAssertEqual(queryString, "price=1.2&values=test1,test2,test3")
    }
    
    func testURLConvertorWithAPIRequest() {
        HTTPMethod.allMethods.forEach { method in
            let apiRequest = MockAPIRequest(method: method)
            XCTAssertNoThrow(try? urlConvertor.makeURL(apiRequest: apiRequest))
        }
    }
    
    func testURLConvertorWithInlineURLAndNoParameters() {
        let apiRequest = MockAPIRequest(method: .get)
        let url = try! urlConvertor.makeURL(apiRequest: apiRequest)
        XCTAssertEqual(url.absoluteString, apiRequest.url)
    }

    func testURLConvertorWithInlineURLAndParameters() {
        let apiRequest = MockAPIRequest(method: .get, parameters: ["value": "test"])
        let url = try! urlConvertor.makeURL(apiRequest: apiRequest)
        XCTAssertEqual(url.absoluteString, "https://api.timburtons.com/v1/products?value=test")
    }
    
    func testURLConvertorWithURLAndNoParameters() {
        HTTPMethod.nonInlineMethods.forEach { method in
            let apiRequest = MockAPIRequest(method: .post)
            let url = try! urlConvertor.makeURL(apiRequest: apiRequest)
            XCTAssertEqual(url.absoluteString, apiRequest.url)
        }
    }
    
    func testURLConvertorWithURLAndParameters() {
        HTTPMethod.nonInlineMethods.forEach { method in
            let apiRequest = MockAPIRequest(method: .post, parameters: ["value": "test"])
            let url = try! urlConvertor.makeURL(apiRequest: apiRequest)
            XCTAssertEqual(url.absoluteString, apiRequest.url)
        }
    }    
}
