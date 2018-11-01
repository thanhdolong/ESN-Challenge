//
//  Location.swift
//  challenge
//
//  Created by Thành Đỗ Long on 30/10/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation

class Location {
    
    // MARK: - Instance Properties
    let identifier: Int?
    let title: String
    let latitude: Double
    let longtitude: Double
    
    init(title: String,
         latitude: Double,
         longtitude: Double) {
        self.identifier = nil
        self.title = title
        self.latitude = latitude
        self.longtitude = longtitude
    }
}
