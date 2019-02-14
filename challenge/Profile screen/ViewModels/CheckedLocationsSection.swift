//
//  LocationsSection.swift
//  challenge
//
//  Created by Thành Đỗ Long on 09/01/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

class CheckedLocationsSection: ProfileSection {
    var type: ProfileSectionType {
        return .locations
    }
    
    var rowCount: Int {
        return locations.count
    }
    
    var sectionTitle: String? {
        return "Checked locations"
    }
    
    var locations: [Location]
    
    
    init(locations: [Location]) {
        self.locations = locations
    }
}

