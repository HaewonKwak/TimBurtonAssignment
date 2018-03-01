//
//  HTTPMethodTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

class HTTPMethodTests: XCTestCase {
    let methods: [HTTPMethod] = [.get, .post, .put, .delete, .patch]

    func testHTTPMethodStrings() {
        let methodStrings = ["GET", "POST", "PUT", "DELETE", "PATCH"]
        zip(methods, methodStrings).forEach { method, string in
            XCTAssertEqual(method.string, string)
        }
    }
    
    func testHTTPMethodInlineURL() {
        methods.forEach { method in
            if method == .get {
                XCTAssertTrue(method.isInlineURL)
            } else {
                XCTAssertFalse(method.isInlineURL)
            }
        }
    }
    
}
