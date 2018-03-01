//
//  Error.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-26.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

enum NetworkError: String, LocalizedError {
    case missingURL = "URL is missing"
}

enum ParserError: String, LocalizedError {
    case unableToParse = "Unable to parse"
    case optionalParsing = "Unable to optional parse"
}
