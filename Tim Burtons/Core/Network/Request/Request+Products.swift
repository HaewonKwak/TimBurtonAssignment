//
//  Request+Products.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-26.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

extension Request {
    struct Products: APIRequest {
        let environment: EnvironmentConfigurable
        let urlPath: String = "v1/products"
        let method: HTTPMethod = .get
        
        init(environment: EnvironmentConfigurable = Environment()) {
            self.environment = environment
        }
    }
}
