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

class MapScreenViewController: UIViewController {
    let regionInMeters: Double = 10000
    var locationManager: CLLocationManager!
    var mapScreenDatasource: MapScreenDatasource!

    @IBOutlet weak var mapView: MKMapView!
    
    static func initFromStoryboard() -> MapScreenViewController {
        let storyboard = UIStoryboard(name: "MapScreen", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()! as! MapScreenViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        // let location = Location(title: "Prague", latitude: 50.08804, longtitude: 50.08804)
        // let prague = CLLocation(latitude: location.latitude, longitude: location.longtitude)
        
        checkLocationServices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension MapScreenViewController {
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
            setupMapView()
            loadMapScreenDatasource()
        } else {
            // TODO: Show aler letting the user know they have to turn this on
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 600
        locationManager.startUpdatingLocation()
    }
    
    private func checkLocationAuthorization() {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            print("Not determined status. Show request for using location.")
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    private func setupMapView() {
        mapView.showsUserLocation = true
        mapView.mapType = .standard
        mapView.userTrackingMode = .follow
    }
    
    private func loadMapScreenDatasource() {
        mapScreenDatasource.mapScreenDatasourceDelegate = self
        mapScreenDatasource.loadLocations()
    }
}

extension MapScreenViewController: MapScreenDatasourceDelegate {
    func didReceiveMonitoringLocations(nearbyRegions: [CLCircularRegion]) {
                
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
        
        print("---- End Notify about monitoring ---")
    }
    
    func didReceiveLocations(locations: [Location]) {
        let filteredAnnotations = mapView.annotations.filter { (annotation) -> Bool in
            if annotation is MKUserLocation { return false }
            return true
        }
        
        mapView.removeAnnotations(filteredAnnotations)
            
        mapView.addAnnotations(locations)
        for annotation in mapView.annotations {
            print("Location: \(annotation.title! ?? "nil")")
        }
    }
    
    func didReceiveCircularOverlay(overlays: [MKOverlay]) {
        mapView.addOverlays(overlays)
    }
}
