//
//  UIView+Util.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-27.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

extension UIView {
    func addSubViewSizeToFit(_ subView: UIView) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
