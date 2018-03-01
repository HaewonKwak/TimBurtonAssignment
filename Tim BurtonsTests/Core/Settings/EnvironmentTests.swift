//
//  EnvironmentTests.swift
//  Tim BurtonsTests
//
//  Created by Haewon Kwak on 2018-02-26.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import XCTest
@testable import Tim_Burtons

class MockEnvironmentDataSource: EnvironmentDataSource {
    var isRegistered: Bool = false
    
    var versionValue: String?
    var buildValue: String?
    
    var urlKey: String
    
    init(urlKey: String) {
        self.urlKey = urlKey
    }
    
    func register(defaults registrationDictionary: [String : Any]) {
        isRegistered = true
    }
    
    func set(_ value: Any?, forKey defaultName: String) {
        guard let value = value as? String else {
            return
        }
        
        switch defaultName {
        case "version_preference":
            versionValue = value
        case "build_preference":
            buildValue = value
        default: break
        }
    }
    
    func string(forKey defaultName: String) -> String? {
        return urlKey
    }

}

class EnvironmentTests: XCTestCase {
    
    var environment: Environment!
    var dataSource: MockEnvironmentDataSource!
    override func setUp() {
        super.setUp()
        dataSource = MockEnvironmentDataSource(urlKey: Environment.devBaseURLKey)
        environment = Environment(dataSource: dataSource)
    }
    
    func testEnvironmentRegisterSettingsDefaults() {
        environment.registerSettingsDefaults()
        XCTAssertTrue(dataSource.isRegistered)
    }
    
    func testEnvironmentUpdateVersionNumber() {
        
        let infoDictionaries: [[String: Any]?] = [nil, [:], [Environment.versionInfoKey: "1.0", Environment.buildInfoKey: "2.0"]]
        let expectedValue: [(String?, String?)] = [(nil, nil), (nil, nil), ("1.0", "2.0")]
        zip(infoDictionaries, expectedValue).forEach { dictionary, value in
            let dataSource = MockEnvironmentDataSource(urlKey: "")
            let environment = Environment(dataSource: dataSource)
            environment.updateVersionNumber(withInfoDictionary: dictionary)
            XCTAssertEqual(dataSource.versionValue, value.0)
            XCTAssertEqual(dataSource.buildValue, value.1)
        }
    }
    
    func testEnvironmentReturningBaseURL() {
        
        let keys = [Environment.devBaseURLKey, Environment.qaBaseURLKey, Environment.productionBaseURLKey]
        keys.forEach { key in
            dataSource.urlKey = key
            let devBaseURL = environment.baseURL
            XCTAssertEqual(devBaseURL, Environment.baseURLs[key])
        }
    }
}
