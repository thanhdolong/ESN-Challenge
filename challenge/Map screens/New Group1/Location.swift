//
//  Location.swift
//  challenge
//
//  Created by Thành Đỗ Long on 30/10/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import MapKit

class Location: NSObject {
    
    let identifier: String
    let name: String
    let type: String
    let latitude: Double
    let longitude: Double
    let location: CLLocation
    
    init(title: String,
         type: String,
         latitude: Double,
         longitude: Double) {
        self.identifier = title
        self.name = title
        self.type = type
        self.latitude = latitude
        self.longitude = longitude
        self.location = CLLocation(latitude: latitude, longitude: longitude)
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
