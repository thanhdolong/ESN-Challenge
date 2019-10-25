//
//  PlayerCell.swift
//  challenge
//
//  Created by Thành Đỗ Long on 07/01/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell, ReusableView {
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var rankLabel: UILabel?
    @IBOutlet weak var sectionLabel: UILabel?
    @IBOutlet weak var pointLabel: UILabel?
    
    var item: Player? {
        didSet {
            guard let player = item else { return }
            nameLabel?.text = player.name
            rankLabel?.text = String(player.rank)
            sectionLabel?.text = player.section
            pointLabel?.text = String(player.point)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
