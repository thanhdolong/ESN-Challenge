//
//  PlayerObject.swift
//  challenge
//
//  Created by Thành Đỗ Long on 07/01/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

import Foundation
import RealmSwift
import Unbox

final class PlayerObject: Object, Unboxable {
    
    @objc dynamic var rank: Int = 0
    @objc dynamic var point: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var section: String = ""
    
    override static func primaryKey() -> String? {
        return "rank"
    }
    
    required convenience init(unboxer: Unboxer) throws {
        self.init()
        
        self.rank = try unboxer.unbox(key: "rank")
        self.point = try unboxer.unbox(key: "point")
        self.name = try unboxer.unbox(key: "name")
        self.country = try unboxer.unbox(key: "country")
        self.section = try unboxer.unbox(key: "section")
    }
}

extension PlayerObject {
    convenience init(player: Player) {
        self.init()
        
        self.rank = player.rank
        self.point = player.point
        self.name = player.name
        self.country = player.country
        self.section = player.section
    }
}
