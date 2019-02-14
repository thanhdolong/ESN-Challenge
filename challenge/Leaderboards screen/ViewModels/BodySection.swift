//
//  LeaderboardSection.swift
//  challenge
//
//  Created by Thành Đỗ Long on 07/01/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

class BodySection: LeaderboardSection {
    var type: LeaderboardSectionType { return .body }
    
    var rowCount: Int { return players.count }
    
    var players: [Player]
    
    init(players: [Player]) {
        self.players = players
    }
}
