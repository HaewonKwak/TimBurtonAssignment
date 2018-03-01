//
//  APIRequestTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

struct MockEnvironment: EnvironmentConfigurable {
    let baseURL = "http://www.rogers.com/"
}

struct MockAPIRequest: APIRequest {
    let environment: EnvironmentConfigurable = MockEnvironment()
    let urlPath = "api/products"
    let method: HTTPMethod = .get
}

class APIRequestTests: XCTestCase {
    
    var apiRequest: APIRequest!
    
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
        let expectedURL = "http://www.rogers.com/api/products"
        XCTAssertEqual(apiRequest.url, expectedURL)
    }
}
