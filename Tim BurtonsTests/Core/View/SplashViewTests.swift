//
//  SplashViewTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

class SplashViewTests: XCTestCase {
    
    func testShowInView() {
        let view = UIView()
        let splashView = SplashView.show(in: view)
        XCTAssertTrue(view.subviews.contains(splashView))
    }
    
    func testRemoveFromView() {
        let view = UIView()
        let splashView = SplashView()
        view.addSubview(splashView)
        
        SplashView.remove(from: view)
        XCTAssertFalse(view.subviews.contains(splashView))
    }
    
}
