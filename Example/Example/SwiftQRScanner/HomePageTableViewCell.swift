//
//  HomePageTableViewCell.swift
//  SwiftQRScanner_Example
//
//  Created by Softech on 7/23/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {

    @IBOutlet weak var InfoListingButton: UIButton!
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var LocationView: UIView!
    @IBOutlet weak var TitleAndDescLabel: UILabel!
    @IBOutlet weak var ListingImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
