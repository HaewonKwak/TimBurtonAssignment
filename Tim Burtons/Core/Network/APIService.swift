//
//  APIService.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-27.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

class APIService {
    static let shared = APIService()
    
    let urlRequestConvertor: URLRequestConvertable
    let session: SessionRequestable
    
    init(urlRequestConvertor: URLRequestConvertable = URLRequestConvertor(), session: SessionRequestable = URLSession.shared) {
        self.urlRequestConvertor = urlRequestConvertor
        self.session = session
    }
}

// MARK: - APIExecutable
extension APIService: APIExecutable {
    func execute(_ request: APIRequestable, completion: @escaping (Result) -> ()) {
        let urlRequest: URLRequest
        
        do {
            urlRequest = try urlRequestConvertor.makeURLRequest(request)
        } catch {
            return completion(.failure(error))
        }
        
        let task = session.dataTask(request: urlRequest) { [unowned self] (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    return completion(.failure(error))
                }
                do {
                    guard let data = data else {
                        throw NetworkError.missingURL
                    }
                    let object = try self.urlRequestConvertor.serialization.decodeObject(with: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

