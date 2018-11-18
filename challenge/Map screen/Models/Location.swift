//
//  Location.swift
//  challenge
//
//  Created by Thành Đỗ Long on 30/10/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import MapKit
import Unbox

final class Location: NSObject, Unboxable {
    
    // MARK: - Instance Properties
    private let radius: Double = 150
    let identifier: String
    let name: String
    let type: String
    let latitude: Double
    let longitude: Double
    var location: CLLocation { return CLLocation(latitude: latitude, longitude: longitude) }
    var circularOverlay: MKCircle { return MKCircle(center: location.coordinate, radius: radius) }
    
    init(title: String,
         type: String,
         latitude: Double,
         longitude: Double) {
        self.identifier = title
        self.name = title
        self.type = type
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(location: LocationObject) {
        self.identifier = location.name
        self.name = location.name
        self.type = location.type
        self.latitude = location.latitude
        self.longitude = location.longitude
    }
    
    required init(unboxer: Unboxer) throws {
        self.identifier = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "title")
        self.type = try unboxer.unbox(key: "type")
        self.latitude = try unboxer.unbox(key: "lat")
        self.longitude = try unboxer.unbox(key: "lng")
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
