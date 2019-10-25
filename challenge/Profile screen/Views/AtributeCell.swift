//
//  AtributeCell.swift
//  challenge
//
//  Created by Thành Đỗ Long on 13/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit

class AtributeCell: UITableViewCell, ReusableView {
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var valueLabel: UILabel?
    
    var item: (title: String, value: String)? {
        didSet {
            
            titleLabel?.text = item?.title
            valueLabel?.text = item?.value
        }
    }
    
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //        // Initialization code
    //    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
