//
//  UIViewController+UIAlert.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-28.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

extension UIViewController {
    func showAlert(title: String, message: String, accept: String = "OK", actionHandler: (() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: accept, style: .default) { _ in
            actionHandler?()
        }
        
        alertController.addAction(acceptAction)
        present(alertController, animated: true)
    }
}
