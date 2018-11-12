//
//  MapScreen+MKMapViewDelegate.swift
//  challenge
//
//  Created by Thành Đỗ Long on 12/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import MapKit

extension MapScreenViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "place"
        if annotation is Location {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.image = UIImage(named: "customPin")
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
            circleRenderer.strokeColor = UIColor(red: 56, green: 162, blue: 207)
            circleRenderer.fillColor = UIColor(red: 56, green: 162, blue: 207).withAlphaComponent(0.4)
            return circleRenderer
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
    
}

