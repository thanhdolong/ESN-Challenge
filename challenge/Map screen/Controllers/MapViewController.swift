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
    let user: Token = Token()
    var locationManager: CLLocationManager!
    var locationsDatasource: LocationsDatasource!
    let api: ChallengeAPI = ChallengeAPI()

    var mapView: MapView! {
        guard isViewLoaded else { return nil }
        return (view as! MapView)
    }
    
    @IBAction func syncLocation(_ sender: UIButton) {
        mapView.syncButton.isEnabled = false
        api.geAllLocationsAsObjects { (respond) in
            do {
                print("status code \(try respond.getStatusCode())")
                if (try respond.getStatusCode() == 204) {
                    self.showAlert(withTitle: nil, message: "Locations are up to date.")
                }
                
                if (try respond.getStatusCode() == 200) {
                    print("Unwrap data")
                    let locationObjects = try respond.unwrap()
                    self.locationsDatasource.saveLocations(locationObjects)
                    print("set hash")
                    LocalDatabase.databaseHash = try respond.getHeaderField(key: "hash") as? String
                    self.locationsDatasource.notifyControler()
                    self.showAlert(withTitle: nil, message: "Locations has been updated.")
                }
            } catch let error as NetworkError {
                print("Network error: \(error.errorMessages)")
            }
            catch {
                print("Unexpected error: \(error).")
            }
            
            self.mapView.syncButton.isEnabled = true
        }
    }
    
    @IBAction func checkLocation(_ sender: UIButton) {
        mapView.checkButton.isEnabled = false
        
        guard let coordinate = locationManager.location?.coordinate else {
            mapView.checkButton.isEnabled = true
            return showAlert(withTitle: nil, message: "Geofencing can not determine your location. Please try it again later.")
        }
        
        let userLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        locationsDatasource.calculateDistance(from: userLocation)
        guard let actualLocation = locationsDatasource.getNearestRegion(from: userLocation, limit: 1) else {
            mapView.checkButton.isEnabled = true
            return showAlert(withTitle: nil, message: "Geofencing can not determie state. Please try it again later.")
        }
        
        guard user.isAccessTokenExist() else {
            mapView.checkButton.isEnabled = true
            return showAlert(withTitle: nil, message: "You have to log in first.")
        }
        
        switch actualLocation.state {
        case .inside:
            locationsDatasource.checkLocation(location: actualLocation)
        case .unknown:
            showAlert(withTitle: nil, message: "Unknown.")
            mapView.checkButton.isEnabled = true
        case .outside:
            showAlert(withTitle: nil, message: "Outside state.")
            mapView.checkButton.isEnabled = true
        }
    }
    
    @IBAction func zoomToCurrentLocation(sender: AnyObject) {
        mapView.map.zoomToUserLocation()
    }
    
    static func storyboardInit() -> MapViewController {
        let storyboard = UIStoryboard(name: "Map", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()! as! MapViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.checkButton.isHidden = false
        checkLocationServices()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mapView.removeFromSuperview()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension MapViewController {
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            enableLocationServices()
            loadMapScreenDatasource()
        } else {
            showAlert(withTitle: nil, message: "Location services is not available on this device.")
        }
    }
    
    func enableLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined, .restricted, .denied:
            print("Not determined status. Show request for using location.")
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }
    
    private func loadMapScreenDatasource() {
        locationsDatasource.mapScreenDatasourceDelegate = self
        locationsDatasource.loadLocations()
    }
}

extension MapViewController: LocationsDatasourceDelegate {
    func didReceiveAlert(message: String) {
        mapView.checkButton.isEnabled = true
        showAlert(withTitle: nil, message: message)
    }
    
    func didReceiveLocations(locations: [Location]) {
        let filteredAnnotations = mapView.map.annotations.filter { (annotation) -> Bool in
            if annotation is MKUserLocation { return false }
            return true
        }
        
        mapView.map.removeAnnotations(filteredAnnotations)
            
        mapView.map.addAnnotations(locations)
        for annotation in mapView.map.annotations {
            print("Location: \(annotation.title! ?? "nil")")
        }
    }
    
    func didReceiveCircularOverlay(overlays: [MKOverlay]) {
        let filteredOverlays = mapView.map.overlays.filter { (overlay) -> Bool in
            if overlay is MKUserLocation { return false }
            return true
        }
        mapView.map.removeOverlays(filteredOverlays)
        mapView.map.addOverlays(overlays)
    }
}
