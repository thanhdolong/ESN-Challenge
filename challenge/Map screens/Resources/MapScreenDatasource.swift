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
    func didReceiveCircularOverlay(overlays: [MKOverlay])
}

class MapScreenDatasource {
    
    let radius: Double = 150
    var locations = [Location]()
    var circularOverlay = [MKOverlay]()
    var monitoringLocations = [Location]()
    
    weak var mapScreenDatasourceDelegate: MapScreenDatasourceDelegate?
    
    func loadData(){
        // TODO: load pins from server (json).

        let location1 = Location(title: "Google HQ", type: "Lorem Ipsum", latitude: 37.422, longitude: -122.084058)
        let location2 = Location(title: "London", type: "Lorem Ipsum", latitude: 51.50998, longitude: -0.118092)
        let location3 = Location(title: "Apple HQ", type: "Lorem Ipsum", latitude: 37.3270145, longitude: -122.0301)
        
        locations.append(location1)
        monitoringLocations.append(location1)
        circularOverlay.append(MKCircle(center: location1.coordinate, radius: radius))
        
        locations.append(location2)
        circularOverlay.append(MKCircle(center: location2.coordinate, radius: radius))
        
        locations.append(location3)
        circularOverlay.append(MKCircle(center: location3.coordinate, radius: radius))

        mapScreenDatasourceDelegate?.didReceiveLocations(locations: locations)
        mapScreenDatasourceDelegate?.didReceiveCircularOverlay(overlays: circularOverlay)
        mapScreenDatasourceDelegate?.didReceiveMonitoringLocations(locations: monitoringLocations)
    }
    
    
}
