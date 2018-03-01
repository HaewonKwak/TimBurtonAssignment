//
//  ParserTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

class ParserTests: XCTestCase {
    
    func testParserIntValue() {
        XCTAssertNotNil(Parser(value: 1).intValue)
    }
    
    func testParserValueIsNil() {
        XCTAssertNil(Parser(value: "test").intValue)
    }

    func testParserDoubleValue() {
        XCTAssertNotNil(Parser(value: 1.0).doubleValue)
    }
    
    func testParserDoubleValueIsNil() {
        XCTAssertNil(Parser(value: false).doubleValue)
    }

    func testParserBoolValue() {
        XCTAssertTrue(Parser(value: true).boolValue!)
        XCTAssertFalse(Parser(value: false).boolValue!)
    }
    
    func testParserBoolValueIsNil() {
        XCTAssertNil(Parser(value: 1).boolValue)
    }

    func testParserStringValue() {
        XCTAssertNotNil(Parser(value: "test").stringValue)
    }
    
    func testParserStringValueIsNil() {
        XCTAssertNil(Parser(value: 1).stringValue)
    }

    func testParserArrayValue() {
        XCTAssertNotNil(Parser(value: [1,2,3]).arrayValue)
    }
    
    func testParserArrayValueIsNil() {
        XCTAssertNil(Parser(value: 1).arrayValue)
    }

    func testParserStringArrayValue() {
        XCTAssertNotNil(Parser(value: ["1", "2"]).stringArrayValue)
    }
    
    func testParserStringArrayValueIsNil() {
        XCTAssertNil(Parser(value: 1).stringArrayValue)
    }

    func testParserDictionalArrayValue() {
        XCTAssertNotNil(Parser(value: [["key": "value"], ["key1": 1]]).dictionalArrayValue)
    }
    
    func testParserDictionalArrayValueIsNil() {
        XCTAssertNil(Parser(value: 1).dictionalArrayValue)
    }

    func testParserDictionaryValue() {
        XCTAssertNotNil(Parser(value: ["key": "value"]).dictionaryValue)
    }
    
    func testParserDictionaryValueIsNil() {
        XCTAssertNil(Parser(value: 1).dictionaryValue)
    }
    
    func testParserSubscript() {
        XCTAssertNotNil(Parser(value:nil)["0"])
    }
}
