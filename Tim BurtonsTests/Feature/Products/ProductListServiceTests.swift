//
//  ProductListServiceTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-03-01.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

struct MockAPIExecutor: APIExecutable {
    func execute(_ request: APIRequestable, completion: @escaping (Result) -> ()) {
        completion(.success(true))
    }
}

class MockProductAPI: APIProtocol {
    
    let environment: EnvironmentConfigurable = MockTimBurtonEnvironment()
    let urlRoute = ""
    var method: HTTPMethod = .get
    
    typealias Item = [Product]
    
    var isParsed = false
    func parseFromResponse(_ response: Any) -> [Product]? {
        isParsed = response as! Bool
        let product = try! Product(parser: Parser(value: Mock.productDictionary))
        return [product]
    }
}


class ProductListServiceTests: XCTestCase {
    
    var service: ProductListService!
    
    override func setUp() {
        super.setUp()
        service = ProductListService(apiExecutor: MockAPIExecutor())
    }
    
    @discardableResult func fetchDataSourceWithMockProductAPI() -> MockProductAPI {
        let request = MockProductAPI()
        service.fetchDataSource(request: request) { _ in }
        return request
    }
    
    func testProductListServiceFetchDataSource() {
        let request = fetchDataSourceWithMockProductAPI()
        XCTAssertTrue(request.isParsed)
    }
    
    func testProductListServiceReturningNumberOfRowsAtFirstTime() {
        XCTAssertEqual(service.numberOfRows(inSection: 0), 0)
    }
    
    func testProductListServiceReturningNumberOfRowsAfterFetching() {
        fetchDataSourceWithMockProductAPI()
        XCTAssertEqual(service.numberOfRows(inSection: 0), 1)
    }
    
    func testProductListServiceReturningItemAtFirstIndexPath() {
        fetchDataSourceWithMockProductAPI()
        let item = service.item(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(item.name, "name Sm.")
        XCTAssertEqual(item.price, "$0.21")
    }
}
