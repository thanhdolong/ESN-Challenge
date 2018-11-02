//
//  MapScreenDatasource.swift
//  challenge
//
//  Created by Thành Đỗ Long on 01/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

protocol MapScreenDatasourceDelegate: class {
    func didReceiveLocations(monitoringLocations: [Location])
}

class MapScreenDatasource {
    
    var monitoringLocations: [Location] = []
    weak var mapScreenDatasourceDelegate: MapScreenDatasourceDelegate?
    
    func loadMonitoringLocations(){
        monitoringLocations = []
        // TODO: load pins from server (json).
        monitoringLocations.append(Location(title: "Apple HQ", type: "Lorem Ipsum", latitude: 37.3270145, longtitude: -122.0301))
        monitoringLocations.append(Location(title: "Google HQ", type: "Lorem Ipsum", latitude: 37.422, longtitude: -122.084058))
        monitoringLocations.append(Location(title: "London", type: "Lorem Ipsum", latitude: 51.50998, longtitude: -0.118092))
        mapScreenDatasourceDelegate?.didReceiveLocations(monitoringLocations: monitoringLocations)
    }
    
}
