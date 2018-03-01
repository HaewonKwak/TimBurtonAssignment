//
//  APIExecutable.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-26.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

protocol APIExecutable {
    func execute(_ request: APIRequest, completion: @escaping (Result) -> ())
}

protocol HTTPBodyEncoding {
    static func encode(withObject object: Any) throws -> Data
}

protocol HTTPResponseDecoding {
    static func decodeObject(with data: Data) throws -> Any
}

protocol Serializable: HTTPBodyEncoding, HTTPResponseDecoding {
    static var httpHeaders: [String: String]  { get }
}

extension JSONSerialization: Serializable {
    static func encode(withObject object: Any) throws -> Data {
        return try data(withJSONObject: object, options: .prettyPrinted)
    }
    
    static func decodeObject(with data: Data) throws -> Any {
        return try jsonObject(with: data, options: .allowFragments)
    }
    
    static var httpHeaders: [String: String] {
        return ["Content-Type": "application/json",
                "Accept": "application/json"]
    }
}

