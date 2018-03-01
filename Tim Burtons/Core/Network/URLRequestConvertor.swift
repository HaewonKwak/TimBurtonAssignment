//
//  URLRequestConvertor.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-03-01.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

struct URLRequestConvertor: URLRequestConvertable {
    
    let serialization: Serializable
    let urlConvertor: URLConvertable
    
    init(serialization: Serializable = JSONSerializer(), urlConvertor: URLConvertable = URLConvertor()) {
        self.serialization = serialization
        self.urlConvertor = urlConvertor
    }
    
    func makeURLRequest(_ apiRequest: APIRequest) throws -> URLRequest {
        
        let url = try urlConvertor.makeURL(apiRequest)
        let body = try serialization.makeHTTPBody(apiRequest)
        
        var urlRequest = URLRequest(url: url, timeoutInterval: apiRequest.timeoutInterval)
        urlRequest.httpMethod = apiRequest.method.string
        urlRequest.httpBody = body
        urlRequest.allHTTPHeaderFields = serialization.makeHTTPHeaders(withAdditionalHeaders: apiRequest.additionalHeaders)
        
        return urlRequest
    }

}
