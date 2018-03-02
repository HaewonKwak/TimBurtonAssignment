//
//  AppDelegate.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-26.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        #if !APPSTORE
            let environment = Environment()
            environment.registerSettingsDefaults()
            environment.updateVersionNumber()
        #endif
        
        initAppearance()
        return true
    }
}

// MARK: - UI Initialize
private extension AppDelegate {
    func initAppearance() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.Helvetica.regular,
                                                            .foregroundColor: UIColor.title]
        
        UIBarButtonItem.appearance().tintColor = .defaultTint
        
        UITabBar.appearance().tintColor = .defaultTint
        UITabBar.appearance().unselectedItemTintColor = .unselectedTabBar
        
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont.Helvetica.regular.withSize(10),
                                                          .foregroundColor: UIColor.unselectedTabBar], for: .normal)
    }
}
