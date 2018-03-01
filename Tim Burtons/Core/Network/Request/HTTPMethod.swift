//
//  HTTPMethod.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-27.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

enum HTTPMethod {
    case get
    case post
    case put
    case patch
    case delete
    
    var string: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .patch: return "PATCH"
        case .delete: return "DELETE"
        }
    }
}

extension HTTPMethod {
    var isInlineURL: Bool {
        return self == .get
    }
}

extension HTTPMethod: Equatable {
    static func ==(lhs: HTTPMethod, rhs: HTTPMethod) -> Bool {
        return lhs.string == rhs.string
    }
}
