//
//  ProfileSections.swift
//  challenge
//
//  Created by Thành Đỗ Long on 09/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation

class AboutmeSection: ProfileSection {
    var type: ProfileSectionType {
        return .aboutMe
    }
    
    var rowCount: Int {
        return attributes.count
    }
    
    var sectionTitle: String? {
        return "About Me"
    }
    
    var attributes = [(title: String, value: String)]()
    
    
    init(user: User) {
        attributes.append((title: "Email", value: user.email))
        attributes.append((title: "First Name", value: user.firstName))
        attributes.append((title: "Last Name", value: user.lastName))
        attributes.append((title: "Gender", value: user.gender))
    }
}

class ProfileHeaderSection: ProfileSection {
    var type: ProfileSectionType {
        return .header
    }
    
    var rowCount: Int {
        return 1
    }
    
    var sectionTitle: String? {
        return nil
    }
    
    var name: String
    var checkedLocation: String
    
    
    init(user: User) {
        name = user.firstName
        checkedLocation = user.checkedLocation
    }
}
