//
//  Request+Products.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-26.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

extension Request {
    struct Products: APIProtocol {

        let environment: EnvironmentConfigurable
        let urlRoute: String = "v1/products"
        let method: HTTPMethod = .get
        
        init(environment: EnvironmentConfigurable = Environment()) {
            self.environment = environment
        }
        
        typealias Item = [Product]
        
        func parseFromResponse(_ response: Any) -> [Product]? {
            guard let productsDictionaries = Parser(value: response)["products"].dictionalArrayValue else {
                return nil
            }
            
            let parsers = productsDictionaries.map { Parser(value: $0) }
            guard let products = try? Product.make(parsers: parsers) else {
                return nil
            }
            
            return products
        }

    }
    
}
