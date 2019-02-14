//
//  User.swift
//  challenge
//
//  Created by Thành Đỗ Long on 05/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation

final class Token {
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "accessToken")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "accessToken")
        }
    }
    
    func isAccessTokenExist() -> Bool {
        guard let acessToken = accessToken  else {
            return false
        }
        
        return acessToken.isEmpty ?  false : true
    }
    
    func deleteAccessToken() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
    }
}
