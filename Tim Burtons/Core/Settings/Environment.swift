//
//  Environment.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-26.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

protocol EnvironmentConfigurable {
    var baseURL: String { get }
}

struct Environment {

    static let devBaseURLKey = "dev"
    static let qaBaseURLKey = "qa"
    static let productionBaseURLKey = "production"
    
    static let versionInfoKey = "CFBundleShortVersionString"
    static let buildInfoKey = "CFBundleVersion"

    #if APPSTORE
    private let defaultBaseURLKey = productionBaseURLKey
    #else
    private let defaultBaseURLKey = devBaseURLKey
    #endif
    
    static let serverPreference = "server_preference"
    static let versionPreference = "version_preference"
    static let buildPreference = "build_preference"
    
    static let baseURLs: [String: String] = [
        devBaseURLKey: "https://dev.api.timburtons.com/",
        qaBaseURLKey: "https://qa.api.timburtons.com/",
        productionBaseURLKey: "https://api.timburtons.com/"
    ]

    private let dataSource: EnvironmentDataSource
    
    init(dataSource: EnvironmentDataSource = UserDefaults.standard) {
        self.dataSource = dataSource
    }
    
    func registerSettingsDefaults() {
        let appDefaults: [String: AnyObject] = [Environment.serverPreference: defaultBaseURLKey as AnyObject]
        dataSource.register(defaults: appDefaults)
    }
    
    func updateVersionNumber(withInfoDictionary infoDictionary: [String: Any]? = Bundle.main.infoDictionary) {
        
        guard let version = infoDictionary?[Environment.versionInfoKey] as? String,
            let build = infoDictionary?[Environment.buildInfoKey] as? String else {
                return
        }
        
        dataSource.set(version, forKey: Environment.versionPreference)
        dataSource.set(build, forKey: Environment.buildPreference)
    }
}

extension Environment: EnvironmentConfigurable {
    var baseURL: String {
        let baseURLKey = dataSource.string(forKey: Environment.serverPreference) ?? defaultBaseURLKey
        return Environment.baseURLs[baseURLKey] ?? ""
    }
}

