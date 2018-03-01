//
//  URLConvertable.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-03-01.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

protocol URLConvertable {
    func makeURL(_ apiRequest: APIRequest) throws -> URL
}

protocol URLRequestConvertable {
    var serialization: Serializable { get }
    func makeURLRequest(_ apiRequest: APIRequest) throws -> URLRequest
}
