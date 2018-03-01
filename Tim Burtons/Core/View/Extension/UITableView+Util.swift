//
//  UITableView+Util.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-27.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

extension UITableView {
    
    func registerCell<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentity)
    }

    func dequeueReusableCell<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath? = nil) -> T where T: ReusableView {
        guard let indexPath = indexPath else {
            guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentity) as? T else {
                fatalError("Could not dequeue cell with identifier: \(T.reuseIdentity)")
            }
            return cell
        }
        
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentity, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentity)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) -> T where T: ReusableView {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentity) as? T else {
            fatalError("Could not dequeue header or footer with identifier: \(T.reuseIdentity)")
        }
        return cell
    }

    func addEmptyFooterView() {
        tableFooterView = UIView()
    }
    
    func setUpAutoSectionHeaderHeightWithEstimatedHeight(_ estimatedHeight: CGFloat) {
        sectionHeaderHeight = UITableViewAutomaticDimension
        estimatedSectionHeaderHeight = estimatedHeight
    }
    
    func setUpAutoSectionFooterHeightWithEstimatedHeight(_ estimatedHeight: CGFloat) {
        sectionFooterHeight = UITableViewAutomaticDimension
        estimatedSectionFooterHeight = estimatedHeight
    }

    func setUpAutoRowHeightWithEstimatedHeight(_ estimatedHeight: CGFloat) {
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = estimatedHeight
    }

}

