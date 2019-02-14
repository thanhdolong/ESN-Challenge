//
//  LogoutCell.swift
//  challenge
//
//  Created by Thành Đỗ Long on 14/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit

class LogoutCell: UITableViewCell, ReusableView {
    @IBOutlet weak var logoutButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func logout(_ sender: UIButton) { }
    
}
