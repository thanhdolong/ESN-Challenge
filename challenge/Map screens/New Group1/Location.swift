//
//  Location.swift
//  challenge
//
//  Created by Thành Đỗ Long on 30/10/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import MapKit
import RealmSwift

class Location: Object {
    
    @objc dynamic var identifier: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    private let radius: Double = 150
    
    var location: CLLocation {
        get{
            return CLLocation(latitude: latitude, longitude: longitude)
        }
    }
    
    var circularOverlay: MKCircle {
        get {
            return MKCircle(center: location.coordinate, radius: radius)
        }
    }
    
    convenience init(title: String,
         type: String,
         latitude: Double,
         longitude: Double) {
        self.init()
        self.identifier = title
        self.name = title
        self.type = type
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension Location: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        get {
            return location.coordinate
        }
    }
  
    var title: String? {
        get {
            return self.name
        }
    }
    
    var subtitle: String? {
        get {
            return self.type
        }
    }
    
}
