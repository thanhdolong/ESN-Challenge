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

class MapScreenViewController: UIViewController {
    let regionInMeters: Double = 10000
    let locationManager: CLLocationManager = CLLocationManager()
    let mapScreenDatasource: MapScreenDatasource = MapScreenDatasource()

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
        mapScreenDatasource.mapScreenDatasourceDelegate = self
        mapScreenDatasource.loadMonitoringLocations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
            setupMapView()
        } else {
            // TODO: Show aler letting the user know they have to turn this on
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationAuthorization() {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            print("Not determined status. Show request for using location.")
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func setupMapView() {
        mapView.showsUserLocation = true
        mapView.mapType = .standard
        mapView.userTrackingMode = .follow
    }
}

extension MapScreenViewController: MapScreenDatasourceDelegate {
    func didReceiveLocations(monitoringLocations: [Location]) {
        mapView.addAnnotations(monitoringLocations)
        mapView.addOverlays(monitoringLocations.compactMap({ (location) -> MKOverlay in
            location.circle
        }))
        for monitoringLocation in monitoringLocations {
            //mapView.addOverlay(MKCircle(center: monitoringLocation.coordinate, radius: 100))
            print("Monitoring location: \(monitoringLocation.name)")
        }
    }
}


extension MapScreenViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "myMonitoringLocation"
        if annotation is Location {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                
                // MARK: remove button for coordinator
                /*
                let removeButton = UIButton(type: .custom)
                removeButton.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
                removeButton.setImage(UIImage(named: "DeleteGeotification")!, for: .normal)
                annotationView?.leftCalloutAccessoryView = removeButton
                */
                
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.lineWidth = 1.0
            circleRenderer.strokeColor = .purple
            circleRenderer.fillColor = UIColor.purple.withAlphaComponent(0.4)
            return circleRenderer
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
    
}

extension MapScreenViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

            
        // MARK - make sure region monitoring is supported
        if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            showAlert(withTitle:"Error", message: "Geofencing is not supported on this device!")
            return
        }
        
        // Mark: Monitoring must have always location
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            showAlert(withTitle:"Warning", message: "Your geotification is saved but will only be activated once you grant Geotify permission to access the device location.")
        }
        
        /*
        let  region = CLCircularRegion(center: (monitoringLocation?.coordinate)!, radius: 300, identifier: "Apple HQ")
        region.notifyOnEntry = true
        region.notifyOnExit = true
        locationManager.startMonitoring(for: region)
        */
        
        for region in locationManager.monitoredRegions {
            print("Monitored region: \(region.identifier)")
        }
        
        locationManager.startUpdatingLocation()

    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        /*
        guard let latestLocation = locations.last else {return}
        print(latestLocation.coordinate)
         */
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("enter to region")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("exit region")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("region error \(error.localizedDescription)")
    }
}
