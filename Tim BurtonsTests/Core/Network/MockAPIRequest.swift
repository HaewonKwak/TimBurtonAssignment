//
//  MockAPIRequest.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

@testable import Tim_Burtons

struct MockAPIRequest: APIRequestable {
    let environment: EnvironmentConfigurable = MockTimBurtonEnvironment()
    let urlRoute = "v1/products"
    let method: HTTPMethod
    let parameters: [String: Any]?
    
    init(method: HTTPMethod, parameters: [String: Any]? = nil) {
        self.method = method
        self.parameters = parameters
    }
}

