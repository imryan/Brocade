//
//  ItemTableViewCell.swift
//  Brocade_Example
//
//  Created by Ryan Cohen on 4/25/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Brocade

class ItemTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet -
    
    @IBOutlet private weak var itemNameLabel: UILabel!
    @IBOutlet private weak var itemDescriptionLabel: UILabel!
    
    // MARK: - Attributes -
    
    static let cellIdentifier: String = "ItemTableViewCellId"
    
    // MARK: - UI Functions -
    
    func setup(with item: Item) {
        itemNameLabel.text = item.name ?? "Unknown Item"
        itemDescriptionLabel.text = item.brandName ?? item.gtin14
    }
}
