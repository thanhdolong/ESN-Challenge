//
//  SettingsViewModeFriendsItem.swift
//  challenge
//
//  Created by Thành Đỗ Long on 26/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import UIKit

class LinkSection: Section {
    var type: SectionType {
        return .links
    }
    
    let items : [Item]
    
    var sectionTitle: String {
        return "Links"
    }
    
    var rowCount: Int {
        return items.count
    }
    
    init(){
        items = [.blog,
                 .facebook,
                 .instagram]
    }
}
