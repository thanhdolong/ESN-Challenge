//
//  LogoutSection.swift
//  challenge
//
//  Created by Thành Đỗ Long on 14/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation

class LogoutSection: ProfileSection {
    var type: ProfileSectionType {
        return .logout
    }
    
    var sectionTitle: String? {
        return nil
    }
    
    var rowCount: Int {
        return 1
    }
    
}
