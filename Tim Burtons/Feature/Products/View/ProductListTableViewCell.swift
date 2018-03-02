//
//  ProductListTableViewCell.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-27.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell, ReusableView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = UIFont.Helvetica.regular
        nameLabel.textColor = .title
        priceLabel.font = UIFont.Helvetica.regular
        priceLabel.textColor = .detail
        tintColor = .cellTint
    }
}
