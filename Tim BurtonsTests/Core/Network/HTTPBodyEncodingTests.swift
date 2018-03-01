//
//  HTTPBodyEncodingTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

class HTTPBodyEncodingTests: XCTestCase {
    
    struct StubHTTPBodyEncoder: HTTPBodyEncoding {
        func encode(withObject object: Any) throws -> Data {
            return Data()
        }
    }
    
    func testHTTPBodyServiceWithInlieURL() {
        let apiRequest = MockAPIRequest(method: .get)
        XCTAssertNil(try StubHTTPBodyEncoder().makeHTTPBody(apiRequest))
    }
    
    func testHTTPBodyServiceWithInlieURLAndParamters() {
        let apiRequest = MockAPIRequest(method: .get, parameters: ["key": "value"])
        XCTAssertNil(try StubHTTPBodyEncoder().makeHTTPBody(apiRequest))
    }
    
    func testHTTPBodyServiceWithURL() {
        HTTPMethod.nonInlineMethods.forEach { method in
            let apiRequest = MockAPIRequest(method: method)
            XCTAssertNil(try! StubHTTPBodyEncoder().makeHTTPBody(apiRequest))
        }
    }
    
    func testHTTPBodyServiceWithURLAndParamters() {
        HTTPMethod.nonInlineMethods.forEach { method in
            let apiRequest = MockAPIRequest(method: method, parameters: ["key": "value"])
            XCTAssertNoThrow(try! StubHTTPBodyEncoder().makeHTTPBody(apiRequest))
        }
    }
}
