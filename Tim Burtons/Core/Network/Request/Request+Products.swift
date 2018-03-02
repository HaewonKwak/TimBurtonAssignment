//
//  Request+Products.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-26.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

enum Request { }

extension Request {
    struct Products: APIProtocol {

        let environment: EnvironmentConfigurable
        let urlRoute = "v1/products"
        let method: HTTPMethod = .get
        
        init(environment: EnvironmentConfigurable = Environment()) {
            self.environment = environment
        }
        
        typealias Item = [Product]
        
        func parseFromResponse(_ response: Any) -> [Product]? {
            return try? Parser(value: response)["products"].objectValues()
        }
    }
}
