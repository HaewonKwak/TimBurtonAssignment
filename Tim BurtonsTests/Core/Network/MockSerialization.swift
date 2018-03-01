//
//  MockSerialization.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-03-01.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

@testable import Tim_Burtons

class MockSerialization: Serializable {
    var isEncode = false
    var isDecode = false
    var httpHeaders: HavingHTTPHeaders.HTTPHeader {
        return ["key": "value"]
    }
    
    func encode(withObject object: Any) throws -> Data {
        isEncode = true
        return Data()
    }
    
    func decodeObject(with data: Data) throws -> Any {
        isDecode = true
        return data
    }
}

