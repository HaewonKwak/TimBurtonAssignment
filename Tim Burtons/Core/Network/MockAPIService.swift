//
//  MockAPIService.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

struct MockAPIService: APIExecutable {
    let bundle: Bundle
    let serialization: Serializable
    
    init(bundle: Bundle = .main, serialization: Serializable = JSONSerializer()) {
        self.bundle = bundle
        self.serialization = serialization
    }
    
    func execute(_ request: APIRequestable, completion: @escaping (Result) -> ()) {
        guard let path = bundle.path(forResource: request.urlRoute.replacingOccurrences(of: "/", with: ":"), ofType: "json") else {
            return completion(.failure(NetworkError.missingURL))
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let response = try serialization.decodeObject(with: data)
            completion(.success(response))
        } catch {
            completion(.failure(error))
        }
    }
}
