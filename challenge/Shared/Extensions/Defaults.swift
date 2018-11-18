//
//  Defaults.swift
//  challenge
//
//  Created by Thành Đỗ Long on 17/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
struct Defaults {
    static let userSessionKey = "com.save.challenge"
    
    static var databaseHash: String? {
        get {
            return UserDefaults.standard.string(forKey: "hash")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "hash")
        }
    }
    
    static func clearHash() {
        UserDefaults.standard.removeObject(forKey: "hash")
    }
    
    static func clearUserData(){
        UserDefaults.standard.removeObject(forKey: userSessionKey)
    }
}
