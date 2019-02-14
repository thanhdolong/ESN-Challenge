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

final class Location: NSObject {
    public enum LocationState : Int {
        case unknown
        case inside
        case outside
    }
    
    // MARK: - Instance Properties
    var radius: Double { return 60 }
    let identifier: Int
    let name: String
    let type: String
    let latitude: Double
    let longitude: Double
    var state: LocationState {
        guard let currentLocation = distanceFromCurrentLocation else {
            return .unknown
        }
        return currentLocation < radius ? .inside : .outside
    }
    
    var location: CLLocation { return CLLocation(latitude: latitude, longitude: longitude) }
    var circularOverlay: MKCircle { return MKCircle(center: location.coordinate, radius: radius) }
    var distanceFromCurrentLocation: Double?
    
    init(identifier: Int,
         title: String,
         type: String,
         latitude: Double,
         longitude: Double) {
        self.identifier = identifier
        self.name = title
        self.type = type
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(location: LocationObject) {
        self.identifier = location.identifier
        self.name = location.name
        self.type = location.type
        self.latitude = location.latitude
        self.longitude = location.longitude
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
