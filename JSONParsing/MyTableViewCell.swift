//
//  MyTableViewCell.swift
//  JSONParsing
//
//  Created by Ekramul Hoque on 10/7/18.
//  Copyright © 2018 Ekramul Hoque. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var dataLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
