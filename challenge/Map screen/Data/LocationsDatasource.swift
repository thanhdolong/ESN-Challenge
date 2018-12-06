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

protocol LocationsDatasourceDelegate: class {
    func didReceiveCircularOverlay(overlays: [MKOverlay])
    func didReceiveLocations(locations: [Location])
    func didReceiveMonitoringLocations(nearbyRegions: [CLCircularRegion])
}

class LocationsDatasource {
    let database: Database
    let sandboxAPI: SandboxAPI = SandboxAPI()
    let locationAPI: LocationAPI = LocationAPI()
    
    weak var mapScreenDatasourceDelegate: LocationsDatasourceDelegate?
    
    init(database: Database) {
        self.database = database
    }
}

extension LocationsDatasource {
    func loadLocations(){
        self.notifyControler()
        
        locationAPI.geAllLocationsAsObjects { (respond) in
            do {
                print("status code \(try respond.getStatusCode())")
                if (try respond.getStatusCode() == 200) {
                    print("Unwrap data")
                    let locationObjects = try respond.unwrap()
                    self.saveLocations(locationObjects)
                    print("set hash")
                    LocalDatabase.databaseHash = try respond.getHeaderField(key: "hash") as? String
                    self.notifyControler()
                }
            } catch let error as NetworkError {
                print("Network error: \(error.errorMessages)")
            }
            catch {
                print("Unexpected error: \(error).")
            }
        }
    }
    
    func notifyAboutClosestMonitoringRegions(from currentLocation: CLLocation) {
        let allRegions = self.database.fetch(with: Location.all)
        
        //Calulate distance of each region's center to currentLocation
        for region in allRegions {
            region.distanceFromCurrentLocation = currentLocation.distance(from: CLLocation(latitude: region.latitude, longitude: region.longitude))
        }
        
        let result = setRegions(for: nearbyRegions(from: allRegions, limit: 3))
        
        mapScreenDatasourceDelegate?.didReceiveMonitoringLocations(nearbyRegions: result)
    }
    
    func getNearestRegion(from currentLocation: CLLocation) -> Location? {
        let allRegions = self.database.fetch(with: Location.all)
        
        //Calulate distance of each region's center to currentLocation
        for region in allRegions {
            region.distanceFromCurrentLocation = currentLocation.distance(from: CLLocation(latitude: region.latitude, longitude: region.longitude))
        }
        
        let result = nearbyRegions(from: allRegions, limit: 1)
        
        guard let firstRegion = result.first else {
            return nil
        }
        
        return firstRegion
    }
}


extension LocationsDatasource {
    func saveLocations(_ locations: [LocationObject]) {
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
    
    private func nearbyRegions(from allRegions: [Location], limit: Int) -> ArraySlice<Location> {
        let nearbyRegions = allRegions.sorted { (firstRegion, secondRegion) -> Bool in
            guard let firstDistance = firstRegion.distanceFromCurrentLocation, let secondDistance = secondRegion.distanceFromCurrentLocation else { return false }
            
            return firstDistance < secondDistance
            }.prefix(limit)
        
        return nearbyRegions
    }
    
    private func setRegions(for regions: ArraySlice<Location>) -> [CLCircularRegion] {
        var result = [CLCircularRegion]()
        for region in regions {
            let region = CLCircularRegion(center: region.coordinate, radius: region.radius, identifier: region.identifier)
            region.notifyOnEntry = true
            region.notifyOnExit = true
            result.append(region)
        }
        
        return result
    }
    
    func notifyControler() {
        print("Notify controler")
        let locations = self.database.fetch(with: Location.all)
        self.mapScreenDatasourceDelegate?.didReceiveLocations(locations: locations)
        self.mapScreenDatasourceDelegate?.didReceiveCircularOverlay(overlays: locations.map({ (location) -> MKOverlay in
            location.circularOverlay
        }))
    }
}
