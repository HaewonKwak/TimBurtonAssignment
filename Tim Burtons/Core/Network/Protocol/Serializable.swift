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

extension HTTPBodyEncoding {
    func makeHTTPBody(_ apiRequest: APIRequestable) throws -> Data? {
        guard !apiRequest.method.isInlineURL,
            let parameter = apiRequest.parameters else {
                return nil
        }
        return try encode(withObject: parameter)
    }
}

protocol HTTPResponseDecoding {
    func decodeObject(with data: Data) throws -> Any
}

protocol HavingHTTPHeaders {
    typealias HTTPHeader = [String: String]
    
    var httpHeaders: HTTPHeader  { get }

}

extension HavingHTTPHeaders {
    func makeHTTPHeaders(withAdditionalHeaders additionalHeaders: HTTPHeader?) -> HTTPHeader {
        guard let additionalHeaders = additionalHeaders else {
            return httpHeaders
        }
        return httpHeaders.merging(additionalHeaders) { $1 }
    }
}

protocol Serializable: HTTPBodyEncoding, HTTPResponseDecoding, HavingHTTPHeaders { }
