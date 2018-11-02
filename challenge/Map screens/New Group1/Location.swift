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
    
    // MARK: - Instance Properties
    let identifier: Int?
    let name: String
    let type: String
    let latitude: Double
    let longtitude: Double
    let location: CLLocation
    
    init(title: String,
         type: String,
         latitude: Double,
         longtitude: Double) {
        self.identifier = nil
        self.name = title
        self.type = type
        self.latitude = latitude
        self.longtitude = longtitude
        self.location = CLLocation(latitude: latitude, longitude: longtitude)
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
