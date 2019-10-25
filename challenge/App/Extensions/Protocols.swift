//
//  Protocols.swift
//  challenge
//
//  Created by Thành Đỗ Long on 13/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
}
