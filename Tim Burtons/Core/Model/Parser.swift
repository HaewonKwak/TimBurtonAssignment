//
//  Parser.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

struct Parser {
    private let value: Any?
    
    init(value: Any?) {
        self.value = value
    }
    
    subscript (key: ParsingKey) -> Parser {
        return self[key.rawValue]
    }

    subscript (key: String) -> Parser {
        return Parser(value: dictionaryValue?[key])
    }
    
    private func value<T>(of type: T.Type) -> T? {
        guard let value = value as? T else {
            return nil
        }
        return value
    }
}

//MARK: Values
extension Parser {
    var intValue: Int? {
        return value(of: Int.self)
    }
    
    var doubleValue: Double? {
        return value(of: Double.self)
    }
    
    var boolValue: Bool? {
        return value(of: Bool.self)
    }
    
    var stringValue: String? {
        return value(of: String.self)
    }
    
    var arrayValue: [Any]? {
        return value(of: [Any].self)
    }
    
    var stringArrayValue: [String]? {
        return value(of: [String].self)
    }
    
    var dictionalArrayValue: [[String: Any]]? {
        return value(of: [[String: Any]].self)
    }
    
    var dictionaryValue: [String: Any]? {
        return value(of: [String: Any].self)
    }
    
    func objectValue<Type>() throws -> Type where Type: Parsing {
        return try Type(parser: self)
    }
    
    func objectValues<Type>() throws -> [Type] where Type: Parsing {
        guard let values = dictionalArrayValue else {
            guard let _ = arrayValue else {
                throw ParserError.unableToParse
            }
            return []
        }
        
        return try Type.make(parsers: values.map { Parser(value: $0) })
    }
}

// MARK: - Throws
extension Optional {
    func wrappedValue() throws -> Wrapped {
        switch self {
        case .some(let wrapped): return wrapped
        case .none: throw ParserError.optionalParsing
        }
    }
}
