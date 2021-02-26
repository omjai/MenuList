//
//  MenuCell.swift
//  MenuList
//
//  Created by APPLE on 25/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var displayNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
