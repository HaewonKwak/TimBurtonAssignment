//
//  URLConvertor.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

struct URLConvertor: URLConvertable {
    
    func makeURL(_ apiRequest: APIRequest) throws -> URL {
        guard apiRequest.method.isInlineURL else {
            return try makeURL(string: apiRequest.url)
        }
        
        var urlString = apiRequest.url
        let queryStirng = convertToQueryString(fromParameters: apiRequest.parameters)
        if !queryStirng.isEmpty {
            urlString += "?\(queryStirng)"
        }
        return try makeURL(string: urlString)
    }
    
    func convertToQueryString(fromParameters parameters: [String: Any]?) -> String {
        guard let parameters = parameters else {
            return ""
        }
        
        return parameters.map { key, value in
            if let dicionary = value as? [String: Any] {
                return convertToQueryString(fromParameters: dicionary)
            } else if let array = value as? [Any] {
                let quertString = array.map { convertToQueryString(fromValue: $0) }.joined(separator: ",")
                return "\(key)=\(quertString)"
            } else {
                return "\(key)=\(convertToQueryString(fromValue: value))"
            }
            }.joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}

// MARK: - Private
private extension URLConvertor {
    func convertToQueryString(fromValue value: Any) -> String {
        if let bool = value as? Bool {
            return bool ? "1" : "0"
        }
        return "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }

    func makeURL(string: String) throws -> URL {
        guard let url = URL(string: string) else {
            throw NetworkError.missingURL
        }
        return url
    }
}
