//
//  ParsingTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

class ParsingTests: XCTestCase {

    struct MockParsing: Parsing {
        init(parser: Parser) throws { }
    }

    private func makeParsers(count: Int) -> [Parser] {
        var parsers: [Parser] = []
        for _ in 0..<count {
            parsers.append(Parser(value: nil))
        }
        return parsers
    }
    
    func testParingMakeWithParsers() {
        let numberOfObjects = 5
        
        let parsers = makeParsers(count: numberOfObjects)
        let mocks = try! MockParsing.make(parsers: parsers)
        
        XCTAssertEqual(mocks.count, numberOfObjects)
    }
    
    func testParingMakeWithEmptyPasers() {
        let numberOfObjects = 0
        
        let parsers = makeParsers(count: numberOfObjects)
        let mocks = try! MockParsing.make(parsers: parsers)
        
        XCTAssertTrue(mocks.isEmpty)
    }
}
