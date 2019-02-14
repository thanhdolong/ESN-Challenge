//
//  Player.swift
//  challenge
//
//  Created by Thành Đỗ Long on 07/01/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

import Foundation
import Unbox

struct Player {
    let rank: Int
    let point: Int
    let name: String
    let country: String
    let section: String
}


extension Player {
    init(object: PlayerObject) {
        self.name = object.name
        self.country = object.country
        self.section = object.section
        self.point = object.point
        self.rank = object.rank
    }
}
