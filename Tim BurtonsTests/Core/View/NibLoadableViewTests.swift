//
//  NibLoadableViewTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

class MockNibLoadableView: UIView, NibLoadableView {}

class NibLoadableViewTests: XCTestCase {
    
    func testNibName() {
        XCTAssertEqual(MockNibLoadableView.nibName, "MockNibLoadableView")
    }
    
    func testLoadFromNib() {
        XCTAssertNotNil(MockNibLoadableView.loadFromNib(in: Bundle(for: MockNibLoadableView.self)))
    }
}
