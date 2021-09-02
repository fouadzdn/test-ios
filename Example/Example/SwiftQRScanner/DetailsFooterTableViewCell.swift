//
//  DetailsFooterTableViewCell.swift
//  SwiftQRScanner_Example
//
//  Created by Softech on 7/23/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class DetailsFooterTableViewCell: UITableViewCell {

    @IBOutlet weak var ValueLabel: UILabel!
    @IBOutlet weak var PlusBUtton: UIButton!
    @IBOutlet weak var MInusButton: UIButton!
    @IBOutlet weak var CounterContainer: UIView!
    @IBOutlet weak var GenerateCodeButton: UIButton!
    @IBOutlet weak var EnterPhoneTextField: UITextField!
    @IBOutlet weak var EnterPhoneLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
