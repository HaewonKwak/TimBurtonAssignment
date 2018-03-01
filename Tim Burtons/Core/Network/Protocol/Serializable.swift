//
//  Serializable.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

protocol HTTPBodyEncoding {
    func encode(withObject object: Any) throws -> Data
}

protocol HTTPResponseDecoding {
    func decodeObject(with data: Data) throws -> Any
}

protocol Serializable: HTTPBodyEncoding, HTTPResponseDecoding {
    var httpHeaders: [String: String]  { get }
}


