//
//  MapScreenViewController
//  challenge
//
//  Created by Thành Đỗ Long on 29/10/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire

class MapViewController: UIViewController {
    var locationManager: CLLocationManager!
    var mapScreenDatasource: MapDatasource!
    var mapScreenView: MapView! {
        guard isViewLoaded else { return nil }
        return (view as! MapView)
    }
    
    @IBAction func openSettings(_ sender: UIButton) {
        let vc = NavigationController(rootViewController: SettingsTableViewController())
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func zoomToCurrentLocation(sender: AnyObject) {
        mapScreenView.map.zoomToUserLocation()
    }
    
    static func storyboardInit() -> MapViewController {
        let storyboard = UIStoryboard(name: "Map", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()! as! MapViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension MapViewController {
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
            startReceivingLocationChanges()
            loadMapScreenDatasource()
        } else {
            showAlert(withTitle: nil, message: "Location services is not available on this device.")
        }
    }
    
    private func startReceivingLocationChanges() {        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100.0
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    private func checkLocationAuthorization() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus != .authorizedWhenInUse && authorizationStatus != .authorizedAlways {
            // User has not authorized access to location information.
            print("Not determined status. Show request for using location.")
            locationManager.requestAlwaysAuthorization()
            return
        }
    }
    
    private func loadMapScreenDatasource() {
        mapScreenDatasource.mapScreenDatasourceDelegate = self
        mapScreenDatasource.loadLocations()
    }
}

extension MapViewController: MapDatasourceDelegate {
    func didReceiveMonitoringLocations(nearbyRegions: [CLCircularRegion]) {
        guard let firstRegion = nearbyRegions.first else {
            return
        }
        
        // Remove all regions were tracking before
        print("---Notify about monitoring---")
        locationManager.monitoredRegions.forEach { (region) in
            print("stop monitoring \(region.identifier)")
            locationManager.stopMonitoring(for: region)
        }
        
        nearbyRegions.forEach { (region) in
            print("start monitoring \(region.identifier)")
            locationManager.startMonitoring(for: region)
        }
        locationManager.startMonitoringVisits()
        locationManager.requestState(for: firstRegion)
        print("---- End Notify about monitoring ---")
    }
    
    func didReceiveLocations(locations: [Location]) {
        let filteredAnnotations = mapScreenView.map.annotations.filter { (annotation) -> Bool in
            if annotation is MKUserLocation { return false }
            return true
        }
        
        mapScreenView.map.removeAnnotations(filteredAnnotations)
            
        mapScreenView.map.addAnnotations(locations)
        for annotation in mapScreenView.map.annotations {
            print("Location: \(annotation.title! ?? "nil")")
        }
    }
    
    func didReceiveCircularOverlay(overlays: [MKOverlay]) {
        mapScreenView.map.addOverlays(overlays)
    }
}
