//
//  SettingsViewModeFriendsItem.swift
//  challenge
//
//  Created by Thành Đỗ Long on 26/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import UIKit

class LinkSection: SettingsSection {
    var type: SettingsSectionType {
        return .links
    }
    
    let items : [SettingsItem]
    
    var sectionTitle: String? {
        return "Quick links"
    }
    
    var rowCount: Int {
        return items.count
    }
    
    init(items: [SettingsItem]){
        self.items = items
    }
}
