//
//  UIColor+Util.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-27.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

// MARK: - Static
extension UIColor {
    static let title = UIColor(red255: 3, green255: 3, blue255: 3)
    static let detail = UIColor(red255: 143, green255: 142, blue255: 148)
    static let cellTint = UIColor(red255: 199, green255: 199, blue255: 204)
    static let defaultTint = UIColor(red255: 0, green255: 118, blue255: 255)
    static let unselectedTabBar = UIColor(red255: 164, green255: 170, blue255: 179)
}

// MARK: - Util
extension UIColor {
    convenience init(red255: CGFloat, green255: CGFloat, blue255: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: red255 / 255.0, green: green255 / 255.0, blue: blue255 / 255.0, alpha: alpha)
    }
}
