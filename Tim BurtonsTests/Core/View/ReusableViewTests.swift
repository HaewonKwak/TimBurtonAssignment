//
//  ReusableViewTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

class MockReusableTableViewCell: UITableViewCell, ReusableView { }

class ReusableViewTests: XCTestCase {
    
    func testReuseIdentifier() {
        XCTAssertEqual(MockReusableTableViewCell.reuseIdentity, "MockReusableTableViewCell")
    }

}
