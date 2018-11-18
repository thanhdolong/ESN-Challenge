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
    
    var monitoringLocations = [Location]()
    weak var mapScreenDatasourceDelegate: MapScreenDatasourceDelegate?
    
    init(database: Database) {
        self.database = database
    }
}

extension MapScreenDatasource {
    func loadLocations(){
        locationAPI.geAllLocationsAsObjects { (respond) in
            do {
                print("status code \(try respond.getStatusCode())")
                if (try respond.getStatusCode() == 200) {
                    print("Unwrap data")
                    let locations = try respond.unwrap()
                    self.save(locations)
                    print("set hash")
                    Defaults.databaseHash = try respond.getHeaderField(key: "hash") as? String
                }
                
                print("Notify controler")
                self.mapScreenDatasourceDelegate?.didReceiveLocations(locations: self.database.fetch(with: Location.all))
            } catch let error {
                print(error)
            }
        }
    }
    
    func loadMonitoringLocations() {
        mapScreenDatasourceDelegate?.didReceiveMonitoringLocations(locations: monitoringLocations)
    }
    
    private func save(_ locations: [LocationObject]) {
        do {
            print("Set valid into false")
            try self.database.update(type: LocationObject.self, where: nil, setValues: ["isValid" : false])
            
            print("Insert objects to Realm")
            try self.database.insertObjects(locations, update: true)
            
            print("Delete invalid Locations")
            try self.database.delete(type: LocationObject.self, where: NSPredicate(format: "isValid = %i", false))
        } catch (let error) {
            print(error)
        }
    }
}
