//
//  ProductTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

extension Dictionary where Key == String, Value == Any {
    func removedValue(forKey key: Key) -> [Key: Value] {
        var newDictionary = self
        newDictionary.removeValue(forKey: key)
        return newDictionary
    }
}

class ProductTests: XCTestCase {

    var productDictionary: [String: Any]!
    
    override func setUp() {
        super.setUp()
        productDictionary = Mock.productDictionary
    }
    
    func testProductInitWithParser() {
        XCTAssertNoThrow(try Product(parser: Parser(value: productDictionary)))
    }
    
    func testProductInitWithMissingRequired() {
        
        XCTAssertThrowsError(try Product(parser: Parser(value: productDictionary.removedValue(forKey: "id"))))
        
        XCTAssertThrowsError(try Product(parser: Parser(value: productDictionary.removedValue(forKey: "name"))))
        
        XCTAssertThrowsError(try Product(parser: Parser(value: productDictionary.removedValue(forKey: "cost"))))
        
        XCTAssertThrowsError(try Product(parser: Parser(value: productDictionary.removedValue(forKey: "type"))))
        
    }
    
    func testProductInitWithMissingOptional() {
        XCTAssertNoThrow(try Product(parser: Parser(value: productDictionary.removedValue(forKey: "size"))))
    }
    
    func testProductParsingProductId() {
        [1, 2, 3, 4, 5].forEach { productId in
            productDictionary["id"] = productId
            let product = try! Product(parser: Parser(value: productDictionary))
            XCTAssertEqual(product.productId, productId)
        }
    }
    
    func testProductParsingName() {
        ["name1", "name2", "name3", "name4", "name5"].forEach { name in
            productDictionary["name"] = name
            let product = try! Product(parser: Parser(value: productDictionary))
            XCTAssertEqual(product.name, name)
        }
    }
    
    func testProductParsingType() {
        let expectedTypes: [Product.ProductType] = [.drink, .food, .unknown]
        zip(["drink", "food", "something"], expectedTypes).forEach { value, expectedType in
            productDictionary["type"] = value
            let product = try! Product(parser: Parser(value: productDictionary))
            XCTAssertEqual(product.productType, expectedType)
        }
    }
    
    func testProductParsingCost() {
        zip([1.0, 0.3, 1.2, 12.31], ["$1.00", "$0.30", "$1.20", "$12.31"]).forEach { value, price in
            productDictionary["cost"] = value
            let product = try! Product(parser: Parser(value: productDictionary))
            XCTAssertEqual(product.price, price)
        }

    }
    
    func testProductParsingSize() {
        
        let expectedSizes: [Product.ProductSize] = [.havingSize(.small), .havingSize(.medium), .havingSize(.large), .none, .none]
        let sizes = ["small", "medium", "large", "unexpected", nil]
        zip(sizes, expectedSizes).forEach { value, size in
            productDictionary["size"] = value
            let product = try! Product(parser: Parser(value: productDictionary))
            XCTAssert(product.productSize == size)
        }
    }
    
    func testProductSizeShortTerm() {
        let sizes: [Product.ProductSize.Size] = [.small, .medium, .large]
        let shorTerms = ["Sm.", "Med.", "Lg."]
        zip(sizes, shorTerms).forEach { size, shorTerm in
            XCTAssertEqual(size.shortTerm, shorTerm)
        }
    }

}
