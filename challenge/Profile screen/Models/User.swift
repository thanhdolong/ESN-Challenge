//
//  User.swift
//  challenge
//
//  Created by Thành Đỗ Long on 07/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Unbox

struct User {
//    enum Gender {
//        case m return "male"
//        case f return "female"
//    }
    let email: String
    let nickName: String
    let firstName: String
    let lastName: String
    let fullName: String
    let gender: String
    let checkedLocation: String
    let locations: [Location]
//    let ESNuniversity: University
}


extension User {
    init(object: UserObject) {
        self.email = object.email
        self.nickName = object.nickName
        self.firstName = object.firstName
        self.lastName = object.lastName
        self.fullName = "\(object.firstName) \(object.lastName)"
        self.gender = object.gender
        self.checkedLocation = object.checkedLocation
        self.locations = Array(object.locations.map({Location.init(location: $0)}))
    }
}
