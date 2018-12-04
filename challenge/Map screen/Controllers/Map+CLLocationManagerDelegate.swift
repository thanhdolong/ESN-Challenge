//
//  MapScreen+CLLocationManagerDelegate.swift
//  challenge
//
//  Created by Thành Đỗ Long on 12/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import CoreLocation

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        // MARK - make sure region monitoring is supported
        if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self){
            mapScreenView.checkButton.isHidden = false
            showAlert(withTitle:"Error", message: "Geofencing is not supported on this device!")
            return
        }
        
        // Mark: Monitoring must have always location
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            showAlert(withTitle:"Warning", message: "Your geotification is saved but will only be activated once you grant Geotify permission to access the device location.")
        }
        
        for region in locationManager.monitoredRegions {
            print("Monitored region: \(region.identifier)")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {return}
        mapScreenDatasource.notifyAboutClosestMonitoringRegions(from: lastLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch state {
        case .unknown:
            print("Cannot determine state of the region.")
            mapScreenView.checkButton.isHidden = false
        case .inside:
            print("Inside the region")
            mapScreenView.checkButton.isHidden = false
        case .outside:
            print("Outside the region")
            mapScreenView.checkButton.isHidden = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            // Location updates are not authorized.
            manager.stopUpdatingLocation()
            print("Access to the location service was denied by the user. Error: \(error)")
            showAlert(withTitle: nil, message: "Access to the location service was denied.")
            return
        }
        
        print("Location Manager failed with the following error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        mapScreenView.checkButton.isHidden = false
        print("Monitoring failed for region with identifier: \(region!.identifier) with error: \(error.localizedDescription)")
    }
}

