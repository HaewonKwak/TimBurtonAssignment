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
    enum BaseURL {
        case dev
        case qa
        case production
        
        init(key: String) {
            #if APPSTORE
                return self = .production
            #endif
            switch key {
            case "qa": self = .qa
            case "production": self = .production
            default: self = .dev
            }
        }
        
        var url: String {
            switch self {
            case .dev: return "https://dev.api.timburtons.com/"
            case .qa: return "https://qa.api.timburtons.com/"
            case .production: return "https://api.timburtons.com/"
            }
        }
        
        var key: String {
            switch self {
            case .dev: return "dev"
            case .qa: return "qa"
            case .production: return "production"
            }
        }
    }
    
    enum InfoKey {
        case version
        case build
        
        var key: String {
            switch self {
            case .version: return "CFBundleShortVersionString"
            case .build: return "CFBundleVersion"
            }
        }
    }
    
    enum Preference {
        case server
        case version
        case build
        
        var key: String {
            switch self {
            case .server: return "server_preference"
            case .version: return "version_preference"
            case .build: return "build_preference"
            }
        }
    }
    
    private let dataSource: EnvironmentDataSource
    
    init(dataSource: EnvironmentDataSource = UserDefaults.standard) {
        self.dataSource = dataSource
    }
    
    func registerSettingsDefaults() {
        let appDefaults: [String: AnyObject] = [Preference.server.key: BaseURL(key: "").key as AnyObject]
        dataSource.register(defaults: appDefaults)
    }
    
    func updateVersionNumber(withInfoDictionary infoDictionary: [String: Any]? = Bundle.main.infoDictionary) {
        
        guard let version = infoDictionary?[InfoKey.version.key] as? String,
            let build = infoDictionary?[InfoKey.build.key] as? String else {
                return
        }
        
        dataSource.set(version, forKey: Preference.version.key)
        dataSource.set(build, forKey: Preference.build.key)
    }
}

extension Environment: EnvironmentConfigurable {
    var baseURL: String {
        let key = dataSource.string(forKey: Preference.server.key) ?? ""
        return BaseURL(key: key).url
    }
}

