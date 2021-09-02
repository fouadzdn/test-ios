//
//  DetailsTableViewCell.swift
//  SwiftQRScanner_Example
//
//  Created by Softech on 7/23/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var OptionLabel: UILabel!
    @IBOutlet weak var CheckButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
