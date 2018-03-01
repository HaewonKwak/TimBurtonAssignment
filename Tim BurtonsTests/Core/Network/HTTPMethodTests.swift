//
//  HTTPMethodTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

extension HTTPMethod {
    static var allMethods: [HTTPMethod] {
        return [.get, .post, .put, .delete, .patch]
    }
    
    static var nonInlineMethods: [HTTPMethod] {
        return allMethods.filter { !$0.isInlineURL }
    }
}

class HTTPMethodTests: XCTestCase {

    func testHTTPMethodStrings() {
        let methodStrings = ["GET", "POST", "PUT", "DELETE", "PATCH"]
        zip(HTTPMethod.allMethods, methodStrings).forEach { method, string in
            XCTAssertEqual(method.string, string)
        }
    }
    
    func testHTTPMethodInlineURL() {
        HTTPMethod.allMethods.forEach { method in
            if method == .get {
                XCTAssertTrue(method.isInlineURL)
            } else {
                XCTAssertFalse(method.isInlineURL)
            }
        }
    }
    
}
