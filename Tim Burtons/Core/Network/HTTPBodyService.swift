//
//  HTTPBodyService.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

struct HTTPBodyService {
    let apiRequest: APIRequest
    
    func makeHTTPBody(encoder: HTTPBodyEncoding) throws -> Data? {
        guard !apiRequest.method.isInlineURL,
            let parameter = apiRequest.parameters else {
                return nil
        }
        return try encoder.encode(withObject: parameter)
    }
}
