//
//  MapScreen+MKMapViewDelegate.swift
//  challenge
//
//  Created by Thành Đỗ Long on 12/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import MapKit

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "place"
        if annotation is Location {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.image = UIImage(named: "customPin2")
                annotationView?.canShowCallout = true
                // MARK: remove button for coordinator
                
//                 let removeButton = UIButton(type: .custom)
//                removeButton.frame = CGRect(x: 0, y: 0, width: 60, height: 23)
//                removeButton.setTitle("CHECK", for: .normal)
//                 removeButton.setImage(UIImage(named: "DeleteGeotification")!, for: .normal)
//                 annotationView?.rightCalloutAccessoryView = removeButton
                
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
            circleRenderer.strokeColor = UIColor(red: 252, green: 116, blue: 34)
            circleRenderer.fillColor = UIColor(red: 252, green: 116, blue: 34).withAlphaComponent(0.4)
            return circleRenderer
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
    
}

