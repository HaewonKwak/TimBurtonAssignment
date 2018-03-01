//
//  APIService.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-27.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

class APIService {
    static let shared = APIService()
    
    typealias HTTPHeader = [String: String]
    
    let serialization: Serializable.Type
    
    init(serialization: Serializable.Type = JSONSerialization.self) {
        self.serialization = serialization
    }
    
    func makeURLRequest(_ request: APIRequest) throws -> URLRequest {
        
        let url = try URLConvertor().makeURL(apiRequest: request)
        let body = try HTTPBodyService(apiRequest: request).makeHTTPBody(encoder: serialization)
        
        var urlRequest = URLRequest(url: url, timeoutInterval: request.timeoutInterval)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = body
        urlRequest.allHTTPHeaderFields = makeHTTPHeaders(withAdditionalHeaders: request.additionalHeaders)
        
        return urlRequest
    }
    
    func makeHTTPHeaders(withAdditionalHeaders additionalHeaders: HTTPHeader?) -> HTTPHeader {
        guard let additionalHeaders = additionalHeaders else {
            return serialization.httpHeaders
        }
        return serialization.httpHeaders.merging(additionalHeaders) { $1 }
    }
}

// MARK: - APIExecutable
extension APIService: APIExecutable {
    func execute(_ request: APIRequest, completion: @escaping (Result) -> ()) {
        let urlRequest: URLRequest
        
        do {
            urlRequest = try makeURLRequest(request)
        } catch {
            return completion(.failure(error))
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [unowned self] (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    return completion(.failure(error))
                }
                do {
                    try NetworkResponseValidator(response: response).validate()
                    guard let data = data else {
                        throw NetworkError.missingURL
                    }
                    let object = try self.serialization.decodeObject(with: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

