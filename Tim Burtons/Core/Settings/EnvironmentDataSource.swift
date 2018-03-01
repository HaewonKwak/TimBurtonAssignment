//
//  EnvironmentDataSource.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-26.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import Foundation

public protocol EnvironmentDataSource {
    func register(defaults registrationDictionary: [String : Any])
    func set(_ value: Any?, forKey defaultName: String)
    func string(forKey defaultName: String) -> String?
}

extension UserDefaults: EnvironmentDataSource { }
