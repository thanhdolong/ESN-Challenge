//
//  ProfileHeaderCell.swift
//  challenge
//
//  Created by Thành Đỗ Long on 14/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UITableViewCell, ReusableView {
    @IBOutlet weak var headerLabel: UILabel?
    @IBOutlet weak var checkedLocationLabel: UILabel?
    
    var name: String? {
        didSet {
            headerLabel?.text = name
        }
    }
    
    var checkedLocation: String? {
        didSet {
            checkedLocationLabel?.text = checkedLocation
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
