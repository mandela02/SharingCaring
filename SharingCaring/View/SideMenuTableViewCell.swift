//
//  SideMenuCollectionViewCell.swift
//  SharingCaring
//
//  Created by TriBQ on 9/21/20.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    
    func createCell(category: Category) {
        let nameString = category.name
        nameLabel.text = nameString.javCategory
        numberLabel.text = "\(category.total)"
    }

}
