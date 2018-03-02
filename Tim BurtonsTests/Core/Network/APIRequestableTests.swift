//
//  APIRequestableTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

class APIRequestableTests: XCTestCase {

    struct MockEnvironment: EnvironmentConfigurable {
        let baseURL = "http://www.rogers.com/"
    }
    
    struct MockAPIRequest: APIRequestable {
        let environment: EnvironmentConfigurable = MockEnvironment()
        let urlRoute = "api/products"
        let method: HTTPMethod = .get
    }

    var apiRequest: APIRequestable!
    
    override func setUp() {
        super.setUp()
        apiRequest = MockAPIRequest()
    }
    
    func testAPIRequestDefaultParameters() {
        XCTAssertNil(apiRequest.parameters)
    }
    
    func testAPIRequestDefaultTimeoutInterval() {
        XCTAssertEqual(apiRequest.timeoutInterval, 60)
    }
    
    func testAPIRequestDefaultAdditaionalHeaders() {
        XCTAssertNil(apiRequest.additionalHeaders)
    }
    
    func testAPIRequestURL() {
        XCTAssertEqual(apiRequest.url, "http://www.rogers.com/api/products")
    }
}

