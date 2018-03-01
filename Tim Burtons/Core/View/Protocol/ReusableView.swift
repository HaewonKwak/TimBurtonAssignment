//
//  ReusableView.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-27.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

protocol ReusableView: class {
    static var reuseIdentity: String { get }
}

extension ReusableView where Self: UIView {
    static var reuseIdentity: String {
        return "\(self)"
    }
}

