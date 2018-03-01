//
//  SplashView.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-27.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

class SplashView: UIView, NibLoadableView {
    @discardableResult static func show(in view: UIView) -> SplashView {
        let splashView = SplashView.loadFromNib()
        view.addSubViewSizeToFit(splashView)
        return splashView
    }
    
    static func remove(from view: UIView) {
        view.subviews.filter { $0 is SplashView }
            .forEach { $0.removeFromSuperview() }
    }
}

