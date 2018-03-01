//
//  ProductListViewController.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-27.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    #if DEBUG
    let service = ProductListService(apiExecutor: MockAPIService())
    #else
    let service = ProductListService()
    #endif
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        fetchDataSource()
    }
}

// MARK: - DataSource
extension ProductListViewController {
    func fetchDataSource() {
        SplashView.show(in: view)
        service.fetchDataSource() { [unowned self] error in
            SplashView.remove(from: self.view)
            guard let error = error else {
                return self.tableView.reloadData()
            }
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
    }
}

// MARK: - UI
extension ProductListViewController {
    func setUpUI() {
        tableView.addEmptyFooterView()
    }
}

// MARK: - UITableViewDataSource
extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ProductListTableViewCell.self, for: indexPath)
        configure(cell, at: indexPath)
        return cell
    }
    
    func configure(_ cell: ProductListTableViewCell, at indexPath: IndexPath) {
        let item = service.item(at: indexPath)
        cell.nameLabel.text = item.name
        cell.priceLabel.text = item.price
    }
}
