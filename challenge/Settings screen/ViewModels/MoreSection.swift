//
//  SettingsViewModeFriendsItem.swift
//  challenge
//
//  Created by Thành Đỗ Long on 26/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation

class MoreSection: Section {
    var type: SectionType {
        return .more
    }
    
    var items : [Item]
    
    var sectionTitle: String {
        return "More"
    }
    
    var rowCount: Int {
        return items.count
    }
    
    init(){
        items = [.rateTheApp,.recomendTheApp,.textMessage]
    }
}
