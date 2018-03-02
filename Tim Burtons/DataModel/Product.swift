//
//  Product.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-27.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

struct Product {
    let productId: Int
    let name: String
    private let size: String?
    private let cost: Double
    private let type: String
}

// MARK: - Computed properties
extension Product {
    enum ProductType {
        case drink
        case food
        case unknown
    }
    
    var productType: ProductType {
        switch type {
        case "drink": return .drink
        case "food": return .food
        default: return .unknown
        }
    }
    
    enum ProductSize: Equatable {
        enum Size: String {
            case small
            case medium
            case large
            
            var shortTerm: String {
                switch self {
                case .small: return "Sm."
                case .medium: return "Med."
                case .large: return "Lg."
                }
            }
        }
        
        case havingSize(Size)
        case none
        
        static func ==(lhs: ProductSize, rhs: ProductSize) -> Bool {
            switch (lhs, rhs) {
            case (.havingSize(let lhsSize), .havingSize(let rhsSize)):
                return lhsSize.rawValue == rhsSize.rawValue
            case (.none, .none):
                return true
            default:
                return false
            }
        }

    }

    var productSize: ProductSize {
        guard let size = size, let definedSize = ProductSize.Size(rawValue: size) else {
            return .none
        }
        
        return .havingSize(definedSize)
    }
    
    var price: String {
        return String(format: "$%.2f", cost)
    }
}

// MARK: - Parsing
extension Product: Parsing {
    enum Keys: String, ParsingKey {
        case productId = "id"
        case name
        case size
        case cost
        case type
    }
    
    init(parser: Parser) throws {
        self.productId = try parser[Keys.productId].intValue.wrappedValue()
        self.name = try parser[Keys.name].stringValue.wrappedValue()
        self.size = parser[Keys.size].stringValue
        self.cost = try parser[Keys.cost].doubleValue.wrappedValue()
        self.type = try parser[Keys.type].stringValue.wrappedValue()
    }
}

