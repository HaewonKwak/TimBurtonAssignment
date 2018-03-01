//
//  Parsing.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

protocol Parsing {
    init(parser: Parser) throws
}

extension Parsing {
    static func make(parsers: [Parser]) throws -> [Self] {
        var values: [Self] = []
        for parser in parsers {
            let value = try Self.init(parser: parser)
            values.append(value)
        }
        return values
    }
}

protocol ParsingKey {
    var rawValue: String { get }
    init?(rawValue: String)
}

