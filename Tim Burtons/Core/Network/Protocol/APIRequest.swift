//
//  APIRequest.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-27.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

protocol APIRequest {
    var environment: EnvironmentConfigurable { get }
    var urlRoute: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var timeoutInterval: TimeInterval { get }
    var additionalHeaders: [String: String]? { get }
}

extension APIRequest {
    
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

enum Request { }
