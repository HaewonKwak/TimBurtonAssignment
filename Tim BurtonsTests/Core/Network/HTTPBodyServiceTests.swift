//
//  HTTPBodyServiceTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

class HTTPBodyServiceTests: XCTestCase {
    
    class StubHTTPBodyEncoder: HTTPBodyEncoding {
        func encode(withObject object: Any) throws -> Data {
            return Data()
        }
    }
    
    func testHTTPBodyServiceWithInlieURL() {
        let apiRequest = MockAPIRequest(method: .get)
        let httpBodyService = HTTPBodyService(apiRequest: apiRequest)
        XCTAssertNil(try httpBodyService.makeHTTPBody(encoder: StubHTTPBodyEncoder()))
    }
    
    func testHTTPBodyServiceWithInlieURLAndParamters() {
        let apiRequest = MockAPIRequest(method: .get, parameters: ["key": "value"])
        let httpBodyService = HTTPBodyService(apiRequest: apiRequest)
        XCTAssertNil(try httpBodyService.makeHTTPBody(encoder: StubHTTPBodyEncoder()))
    }
    
    func testHTTPBodyServiceWithURL() {
        HTTPMethod.nonInlineMethods.forEach { method in
            let apiRequest = MockAPIRequest(method: method)
            let httpBodyService = HTTPBodyService(apiRequest: apiRequest)
            XCTAssertNil(try! httpBodyService.makeHTTPBody(encoder: StubHTTPBodyEncoder()))
       }
    }
    
    func testHTTPBodyServiceWithURLAndParamters() {
        HTTPMethod.nonInlineMethods.forEach { method in
            let apiRequest = MockAPIRequest(method: method, parameters: ["key": "value"])
            let httpBodyService = HTTPBodyService(apiRequest: apiRequest)
            XCTAssertNotNil(try! httpBodyService.makeHTTPBody(encoder: StubHTTPBodyEncoder()))
        }
    }
}
