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
    func dataTaskWith(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> SessionDataTaskable
}

protocol SessionDataTaskable {
    func resume()
}

extension URLSessionDataTask: SessionDataTaskable { }

extension URLSession: SessionRequestable {
    func dataTaskWith(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> SessionDataTaskable {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}


