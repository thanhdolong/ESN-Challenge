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
import RealmSwift
import Unbox

protocol MapScreenDatasourceDelegate: class {
    func didReceiveLocations(locations: [Location])
    func didReceiveMonitoringLocations(locations: [Location])
}

class MapScreenDatasource {
    let database: Database
    let sandboxAPI: SandboxAPI = SandboxAPI()
    let locationAPI: LocationAPI = LocationAPI()
    
    var locations = [LocationObject]()
    var monitoringLocations = [Location]()
    var hash: String = "hash"
    weak var mapScreenDatasourceDelegate: MapScreenDatasourceDelegate?
    
    init(database: Database) {
        self.database = database
    }
}

extension MapScreenDatasource {
    func loadLocations(){
        locationAPI.geAllLocations { (respond) in
            do {
                let result = try respond.unwrap()
                print("wtf???? \(result)")
            } catch let error {
                print("chyba \(error)")
            }
        }
        
        sandboxAPI.getStatus(id: 500) { (data, error) in
            guard let data = data else {
                if let error = error {
                    print("> error \(error.errorMessages), \(error.statusCode)")
                }
                return
            }
            
            print("> data \(data)")
        }
        
        
        if hash != "hash" {
            print("Delete Realm Database")
            try! database.deleteAllFromDatabase()
            
            print("Setting Realm Database and save data")
            let location1 = LocationObject(title: "Google HQ", type: "Lorem Ipsum", latitude: 37.422, longitude: -122.084058)
            let location2 = LocationObject(title: "London", type: "Lorem Ipsum", latitude: 51.50998, longitude: -0.118092)
            let location3 = LocationObject(title: "Apple HQ", type: "Lorem Ipsum", latitude: 37.3270145, longitude: -122.0301)
            let location4 = LocationObject(title: "Žabovřesky", type: "Lorem Ipsum", latitude: 49.213691, longitude: 16.574814)
            
            locations.append(location1)
            locations.append(location2)
            locations.append(location3)
            locations.append(location4)
            try! database.insertObjects(locations, update: true)
            print("> databaze[insert]: \(database.fetch(with: Location.all).debugDescription)")
        }
        
        mapScreenDatasourceDelegate?.didReceiveLocations(locations: database.fetch(with: Location.all))
    }
    
    func loadMonitoringLocations() {
        mapScreenDatasourceDelegate?.didReceiveMonitoringLocations(locations: monitoringLocations)
    }
}
