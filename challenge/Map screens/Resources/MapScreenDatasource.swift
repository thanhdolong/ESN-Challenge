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
    func didReceiveData(monitoringLocations: [Location])
}

class MapScreenDatasource {
    
    var monitoringLocations: [Location] = []
    weak var mapScreenDatasourceDelegate: MapScreenDatasourceDelegate?
    
    func loadMonitoringLocations(){
        monitoringLocations = []
        // TODO: load pins from server (json).
        monitoringLocations.append(Location(title: "Apple HQ", latitude: 37.3270145, longtitude: -122.0301))
        monitoringLocations.append(Location(title: "Google HQ", latitude: 37.422, longtitude: -122.084058))
        
        mapScreenDatasourceDelegate?.didReceiveData(monitoringLocations: monitoringLocations)
    }
    
}
