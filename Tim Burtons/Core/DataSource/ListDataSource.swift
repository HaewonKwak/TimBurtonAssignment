//
//  ListDataSource.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-27.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

protocol ListDataSource {
    associatedtype Item
    
    var numberOfSections: Int { get }
    func numberOfRows(inSection section: Int) -> Int
    func item(at indexPath: IndexPath) -> Item
}

extension ListDataSource {
    var numberOfSections: Int {
        return 1
    }
}
