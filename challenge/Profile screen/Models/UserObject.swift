//
//  UserObject.swift
//  challenge
//
//  Created by Thành Đỗ Long on 07/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

final class UserObject: Object, Unboxable {
    
    @objc dynamic var uuid: String = LocalDatabase.userSessionKey
    @objc dynamic var email: String = ""
    @objc dynamic var nickName: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var checkedLocation: String = ""
    var locations = List<LocationObject>()
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
    
    required convenience init(unboxer: Unboxer) throws {
        self.init()
        self.email = try unboxer.unbox(key: "email")
        self.firstName = try unboxer.unbox(key: "firstname")
        self.lastName = try unboxer.unbox(key: "lastname")
        self.gender = try unboxer.unbox(key: "gender")
        self.checkedLocation = try unboxer.unbox(key: "checkedLocation")
        let unboxLocation: [LocationObject] = try unboxer.unbox(key: "locations")
        locations.append(objectsIn: unboxLocation)
    }
}

extension UserObject {
    convenience init(user: User) {
        self.init()
        
        let locationsObject = List<LocationObject>()
        let locations = user.locations.map({LocationObject.init(location: $0)})
        locationsObject.append(objectsIn: locations)
        
        self.nickName = user.nickName
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.gender = user.gender
        self.checkedLocation = user.checkedLocation
        self.locations = locationsObject
    }
}
