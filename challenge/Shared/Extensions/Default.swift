//
//  Defaults.swift
//  challenge
//
//  Created by Thành Đỗ Long on 17/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import UIKit

struct Default {
    static let userSessionKey = "com.save.challenge"
    
    static var databaseHash: String? {
        get {
            return UserDefaults.standard.string(forKey: "hash")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "hash")
        }
    }
    
    static var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "accessToken")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "accessToken")
        }
    }
    
    static func clearHash() {
        UserDefaults.standard.removeObject(forKey: "hash")
    }
    
    static func clearUserData(){
        UserDefaults.standard.removeObject(forKey: userSessionKey)
    }
}


private protocol ThemeScheme {
    var fonts: FontScheme {get}
    var colours: ColourScheme {get}
}

public struct Theme: ThemeScheme{
    
    public let fonts: FontScheme
    public let colours: ColourScheme
    
    public init(){
        self.fonts = Fonts()
        self.colours = Colours()
    }
}

public protocol ColourScheme {
    var primaryColor: UIColor {get} // default colour in scheme
    var textOnPrimaryColour: UIColor {get}
    
    var secondaryColor: UIColor {get} // ie. selected colour of controls
    
    var black: UIColor {get}
    var white: UIColor {get}
    
    var lightGrey: UIColor {get}
    var darkGrey: UIColor {get}
}

private struct Colours: ColourScheme {
    public let primaryColor = UIColor(red: 0, green: 24, blue: 72)
    public let textOnPrimaryColour = UIColor(red:0.85, green:0.92, blue:0.89, alpha:1.00)
    
    public let secondaryColor = UIColor(red: 145, green: 145, blue: 145)
    
    public let black = UIColor(red:0.08, green:0.06, blue:0.13, alpha:1.00)
    public let white = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.00)
    
    public let lightGrey = UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.00)
    public let darkGrey = UIColor(red:0.56, green:0.56, blue:0.58, alpha:1.00)
}

public protocol FontScheme{
    var tapBarTitle: UIFont {get}
    var bodyRegular: UIFont {get}
    var titleMedium: UIFont {get}
    var navigationTitle: UIFont {get}
}

private struct Fonts: FontScheme {
    public let titleMedium = UIFont(name: "Montserrat-SemiBold", size: 17)!
    public let navigationTitle = UIFont(name: "Montserrat-SemiBold", size: 34)!
    public let bodyRegular = UIFont(name: "Montserrat-Regular", size: 15)!
    public let tapBarTitle = UIFont(name: "Montserrat-SemiBold", size: 10)!
}
