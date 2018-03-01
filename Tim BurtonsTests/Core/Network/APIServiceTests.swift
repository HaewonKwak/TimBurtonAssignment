//
//  APIServiceTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-03-01.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

class APIServiceTests: XCTestCase {
    
    class MockURLRequestConvertor: URLRequestConvertable {
        let serialization: Serializable = MockSerialization()
        var shouldThrowError = false
        func makeURLRequest(_ apiRequest: APIRequest) throws -> URLRequest {
            if shouldThrowError {
                throw TestError.error
            }
            return URLRequest(url: URL(string: "http://test.com")!)
        }
    }

    class MockSession: SessionRequestable {
        struct MockURLSessionDataTask: SessionDataTaskable {
            func resume() {}
        }
        
        enum Response {
            case success(Data)
            case failure(Error)
        }
        
        var response: Response
        init(response: Response) {
            self.response = response
        }
        
        func dataTaskWith(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> SessionDataTaskable {
            switch response {
            case .success(let data):
                completionHandler(data, nil, nil)
            case .failure(let error):
                completionHandler(nil, nil, error)
            }
            return MockURLSessionDataTask()
        }
    }
    
    var urlRequestConvertor: MockURLRequestConvertor!
    
    override func setUp() {
        super.setUp()
        urlRequestConvertor = MockURLRequestConvertor()
    }
    
    func testAPIServiceExcueteIfMakingURLRequestFailed() {
        urlRequestConvertor.shouldThrowError = true
        let session = MockSession(response: .success(Data()))
        let apiService = APIService(urlRequestConvertor: urlRequestConvertor, session: session)
        let apiRequest = MockAPIRequest(method: .get)
        apiService.execute(apiRequest) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testAPIServiceExcueteIfSuccess() {
        let expectation = XCTestExpectation(description: "API Reqeust excuting.")
        let session = MockSession(response: .success(Data()))
        let apiService = APIService(urlRequestConvertor: urlRequestConvertor, session: session)
        let apiRequest = MockAPIRequest(method: .get)
        apiService.execute(apiRequest) { result in
            XCTAssertTrue(result.isSuccess)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testAPIServiceExcueteIfError() {
        let expectation = XCTestExpectation(description: "API Reqeust excuting.")
        let session = MockSession(response: .failure(TestError.error))
        let apiService = APIService(urlRequestConvertor: urlRequestConvertor, session: session)
        let apiRequest = MockAPIRequest(method: .get)
        apiService.execute(apiRequest) { result in
            XCTAssertFalse(result.isSuccess)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
