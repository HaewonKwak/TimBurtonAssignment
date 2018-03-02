//
//  APIProtocol.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-27.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

protocol APIRequestable {
    var environment: EnvironmentConfigurable { get }
    var urlRoute: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var timeoutInterval: TimeInterval { get }
    var additionalHeaders: [String: String]? { get }
}

extension APIRequestable {
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var timeoutInterval: TimeInterval {
        return 60
    }
    
    var additionalHeaders: [String: String]? {
        return nil
    }
    
    var url: String {
        return "\(environment.baseURL)\(urlRoute)"
    }
}

protocol APIResponsable {
    associatedtype Item
    func parseFromResponse(_ response: Any) -> Item?
}

protocol APIProtocol: APIRequestable, APIResponsable { }

enum Request { }
