//
//  JSONSerializerTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

class JSONSerializerTests: XCTestCase {
    let jsonSerializer = JSONSerializer()

    func testJSONSerializerHTTPHeaders() {
        let headers = ["Content-Type": "application/json", "Accept": "application/json"]
        XCTAssertEqual(jsonSerializer.httpHeaders, headers)
    }
    
    func testJSONSerializerEncode() {
        let object: [String: Any] = ["value": "test", "cost": 1.0]
        XCTAssertNoThrow(try jsonSerializer.encode(withObject: object))
    }

    func testJSONSerializerDecode() {
        let data = "{\"value\": \"test\", \"cost\": 1.0}".data(using: .utf8)!
        XCTAssertNoThrow(try jsonSerializer.decodeObject(with: data))
    }
}


