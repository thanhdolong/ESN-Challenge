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
    func didReceiveLocations(locations: [Location])
    func didReceiveMonitoringLocations(locations: [Location])
}

class MapScreenDatasource {
    var locations = [Location]()
    var circularOverlay = [MKOverlay]()
    var monitoringLocations = [Location]()
    
    weak var mapScreenDatasourceDelegate: MapScreenDatasourceDelegate?
    
    func loadData(){
        // TODO: load pins from server (json).

        let location1 = Location(title: "Google HQ", type: "Lorem Ipsum", latitude: 37.422, longitude: -122.084058)
        let location2 = Location(title: "London", type: "Lorem Ipsum", latitude: 51.50998, longitude: -0.118092)
        let location3 = Location(title: "Apple HQ", type: "Lorem Ipsum", latitude: 37.3270145, longitude: -122.0301)
        let location4 = Location(title: "Žabovřesky", type: "Lorem Ipsum", latitude: 49.213691, longitude: 16.574814)
        
        
        locations.append(location1)
        monitoringLocations.append(location1)
        
        locations.append(location2)
        
        locations.append(location3)
        
        locations.append(location4)
        
        mapScreenDatasourceDelegate?.didReceiveLocations(locations: locations)
        mapScreenDatasourceDelegate?.didReceiveMonitoringLocations(locations: monitoringLocations)
    }
    
    
}
