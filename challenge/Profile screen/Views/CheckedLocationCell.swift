//
//  CheckedLocationCell.swift
//  challenge
//
//  Created by Thành Đỗ Long on 09/01/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit
import CoreLocation

class CheckedLocationCell: UITableViewCell, ReusableView {

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var adressLabel: UILabel?
    
    var item: Location? {
        didSet {
            let geoCoder = CLGeocoder()
            guard let item = item else { return }
            titleLabel?.text = item.name
            
            geoCoder.reverseGeocodeLocation(item.location) { (placeMarks, error) in
                guard let placeMark = placeMarks?.first else { return }
                self.adressLabel?.text = placeMark.administrativeArea
            }
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
