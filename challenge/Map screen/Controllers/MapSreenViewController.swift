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
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension MapScreenViewController {
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
            setupMapView()
            loadMonitoringLocations()
        } else {
            // TODO: Show aler letting the user know they have to turn this on
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
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
    
    private func loadMonitoringLocations() {
        mapScreenDatasource.mapScreenDatasourceDelegate = self
        mapScreenDatasource.loadLocations()
    }
}

extension MapScreenViewController: MapScreenDatasourceDelegate {
    func didReceiveMonitoringLocations(locations: [Location]) {
        // Remove all regions were tracking before
        for region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
        
        for monitoringLocation in locations {
            let  region = CLCircularRegion(center: monitoringLocation.coordinate, radius: 150, identifier: monitoringLocation.identifier)
            region.notifyOnEntry = true
            region.notifyOnExit = true
            locationManager.startMonitoring(for: region)
            print("Monitoring: \(monitoringLocation.name)")
        }
    }
    
    func didReceiveLocations(locations: [Location]) {
        mapView.addAnnotations(locations)
        mapView.addOverlays(locations.map({ (location) -> MKOverlay in
            location.circularOverlay
        }))

        for annotation in mapView.annotations {
            print("Location: \(annotation.title! ?? "nil")")
        }
    }
    
    func didReceiveCircularOverlay(overlays: [MKOverlay]) {
        mapView.addOverlays(overlays)
    }
}
