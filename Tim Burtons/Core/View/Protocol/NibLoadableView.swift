//
//  NibLoadableView.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-27.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return "\(self)"
    }
    
    static func loadFromNib(in bundle: Bundle = .main) -> Self {
        guard let view = bundle.loadNibNamed(nibName, owner: nil, options: nil)?.first as? Self else {
            fatalError("Could not load view with nib name: \(nibName), bundle: \(bundle)")
        }
        return view
    }
}

