//
//  JSONSerializer.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

struct JSONSerializer: Serializable {
    
    var httpHeaders: [String: String] {
        return ["Content-Type": "application/json",
                "Accept": "application/json"]
    }
    
    func encode(withObject object: Any) throws -> Data {
        return try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
    }
    
    func decodeObject(with data: Data) throws -> Any {
        return try JSONSerialization.jsonObject(with: data, options: .allowFragments)
    }
}
