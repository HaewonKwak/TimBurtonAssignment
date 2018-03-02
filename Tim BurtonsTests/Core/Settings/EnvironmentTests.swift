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
    
    typealias BaseURL = Environment.BaseURL
    typealias InfoKey = Environment.InfoKey
    typealias Preference = Environment.Preference
    
    override func setUp() {
        super.setUp()
        dataSource = MockEnvironmentDataSource(urlKey: BaseURL.dev.key)
        environment = Environment(dataSource: dataSource)
    }
    
    func testEnvironmentRegisterSettingsDefaults() {
        environment.registerSettingsDefaults()
        XCTAssertTrue(dataSource.isRegistered)
    }
    
    func testEnvironmentUpdateVersionNumber() {
        
        let infoDictionaries: [[String: Any]?] = [nil, [:], [InfoKey.version.key: "1.0", InfoKey.build.key: "2.0"]]
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
        
        let keys: [BaseURL] = [.dev, .qa, .production]
        keys.forEach { key in
            dataSource.urlKey = key.key
            let devBaseURL = environment.baseURL
            XCTAssertEqual(devBaseURL, key.url)
        }
    }
}
