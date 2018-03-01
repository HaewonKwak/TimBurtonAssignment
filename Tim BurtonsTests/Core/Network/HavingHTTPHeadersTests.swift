//
//  HavingHTTPHeaderTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

class HavingHTTPHeaderTests: XCTestCase {
    
    struct MockHTTPHeaders: HavingHTTPHeaders {
        var httpHeaders: HavingHTTPHeaders.HTTPHeader {
            return ["key": "value"]
        }
    }
    
    let sut = MockHTTPHeaders()
    
    func testHTTPHeadersMakeNewHeadersWithoutAdditional() {
        let originalHeaders = sut.httpHeaders
        let newHeaders = sut.makeHTTPHeaders(withAdditionalHeaders: nil)
        XCTAssertEqual(newHeaders, originalHeaders)
    }
    
    func testHTTPHeadersMakeNewHeadersWithAdditional() {
        let originalHeaders = sut.httpHeaders
        let newHeaders = sut.makeHTTPHeaders(withAdditionalHeaders: ["extra": "value"])
        XCTAssertGreaterThan(newHeaders.count, originalHeaders.count)
    }
    
    func testHTTPHeadersOverrideNewHeadersWithAdditional() {
        let originalHeaders = sut.httpHeaders
        let newHeaders = sut.makeHTTPHeaders(withAdditionalHeaders: ["key": "newValue"])
        XCTAssertEqual(newHeaders.count, originalHeaders.count)
        XCTAssertNotEqual(newHeaders, originalHeaders)
    }
}
