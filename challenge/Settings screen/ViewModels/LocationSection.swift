//
//  GeneralSection.swift
//  challenge
//
//  Created by Thành Đỗ Long on 05/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation

class LocationSection: SettingsSection {
    var type: SettingsSectionType {
        return .general
    }
    
    var items : [SettingsItem]
    
    var sectionTitle: String? {
        return "Location settings"
    }
    
    var rowCount: Int {
        return items.count
    }
    
    init(user: Token, items: [SettingsItem]){
        self.items = items
        
//        if user.isAccessTokenExist() {
//            self.items.insert(.addLocation, at: 0)
//        }
    }
}
