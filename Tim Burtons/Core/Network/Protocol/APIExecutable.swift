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

protocol SessionRequestable {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
}

extension URLSession: SessionRequestable { }
