//
//  MockAPIService.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

struct MockAPIService: APIExecutable {
    let bundle: Bundle
    let serialization: Serializable.Type
    
    init(bundle: Bundle = .main, serialization: Serializable.Type = JSONSerialization.self) {
        self.bundle = bundle
        self.serialization = serialization
    }
    
    func execute(_ request: APIRequest, completion: @escaping (Result) -> ()) {
        guard let path = bundle.path(forResource: request.urlPath.replacingOccurrences(of: "/", with: ":"), ofType: "json") else {
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