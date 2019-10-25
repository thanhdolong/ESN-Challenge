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
    func didReceiveAlert(message: String)
}

class LocationsDatasource {
    var lastCalculation: CLLocation?
    let database: Database
    var locations: [Location]?
    let sandboxAPI: SandboxAPI = SandboxAPI()
    let api: ChallengeAPI = ChallengeAPI()
    
    weak var mapScreenDatasourceDelegate: LocationsDatasourceDelegate?
    
    init(database: Database) {
        self.database = database
    }
}

extension LocationsDatasource {
    func loadLocations(){
        self.notifyControler()
        
        api.geAllLocationsAsObjects { (respond) in
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
                self.sendMessage(text: error.errorMessages)
                print("Network error: \(error.errorMessages)")
            }
            catch {
                self.sendMessage(text: error.localizedDescription)
                print("Unexpected error: \(error).")
            }
        }
    }
    
    func canRecalculateDistance(from currentLocation: CLLocation) -> Bool {
        if let lastCalculation = lastCalculation, lastCalculation.distance(from: currentLocation) < 500 {
            return false
        }
        
        return true
    }
    
    func calculateDistance(from currentLocation: CLLocation) {
        let allRegions = self.database.fetch(with: Location.all)
        
        //Calulate distance of each region's center to currentLocation
        for region in allRegions {
            region.distanceFromCurrentLocation = currentLocation.distance(from: CLLocation(latitude: region.latitude, longitude: region.longitude))
        }
        
        lastCalculation = currentLocation
        locations = allRegions
    }
    
    func getNearestRegion(from currentLocation: CLLocation, limit: Int) -> Location? {
        //MARK: Calulate distance of each region's center to currentLocation
        guard let allRegions = locations else { return nil }
        
        let result = nearbyRegions(from: allRegions, limit: 1)
        
        guard let firstRegion = result.first else { return nil }
        
        return firstRegion
    }
}


extension LocationsDatasource {
    func checkLocation(location: Location) {
        api.sendLocationCheck(location: location.identifier) { (respond) in
            do {
                print("status code \(try respond.getStatusCode())")
                if (try respond.getStatusCode() == 200) {
                    if let body = try respond.getBody() as? [String: Any],
                        let message = body["message"] as? String {
                        self.sendMessage(text: message)
                    }
                }
            } catch let error as NetworkError {
                self.sendMessage(text: error.errorMessages)
                print("Network error: \(error.errorMessages)")
            }
            catch {
                self.sendMessage(text: error.localizedDescription)
                print("Unexpected error: \(error).")
            }
            
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    func saveLocations(_ locations: [LocationObject]) {
        do {
            print("Set valid into false")
            try self.database.update(type: LocationObject.self, where: nil, setValues: ["isValid" : false])
            
            print("Insert objects to Realm")
            try self.database.insertObjects(locations, update: .all)
            
            print("Delete invalid Locations")
            try self.database.delete(type: LocationObject.self, where: NSPredicate(format: "isValid = %i", false))
        } catch (let error) {
            print(error)
        }
    }
    
    private func sendMessage(text: String) {
        mapScreenDatasourceDelegate?.didReceiveAlert(message: text)
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
            let region = CLCircularRegion(center: region.coordinate, radius: region.radius, identifier: "\(region.identifier) \(region.name)" )
            region.notifyOnEntry = true
            region.notifyOnExit = true
            result.append(region)
        }

        return result
    }
    
    func notifyControler() {
        self.locations = self.database.fetch(with: Location.all)
        guard let locations = self.locations else { return }
        print(locations)
        
        print("Notify controler")
        self.mapScreenDatasourceDelegate?.didReceiveLocations(locations: locations)
        self.mapScreenDatasourceDelegate?.didReceiveCircularOverlay(overlays: locations.map({ (location) -> MKOverlay in
            location.circularOverlay
        }))
    }
}
