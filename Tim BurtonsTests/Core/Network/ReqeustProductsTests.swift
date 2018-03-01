//
//  ReqeustProductsTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons


class ReqeustProductsTests: XCTestCase {

    let request = Request.Products(environment: MockTimBurtonEnvironment())
    
    func testRequestProducsURL() {
        XCTAssertEqual(request.url, "https://api.timburtons.com/v1/products")
    }
    
    func testRequestProducsMethod() {
        XCTAssertEqual(request.method, .get)
    }
    
}
