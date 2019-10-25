//
//  MapScreenView.swift
//  challenge
//
//  Created by Thành Đỗ Long on 28/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit
import MapKit

public final class MapView: UIView {
    private let theme = Theme()
    
    @IBOutlet public var syncLocation: UIButton!
    
    @IBOutlet public var checkButton: UIButton! {
        didSet {
            checkButton.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet public var zoomUserLocationButton: UIButton!{
        didSet {
            zoomUserLocationButton.tintColor = theme.colours.primaryColor
        }
    }
    
    @IBOutlet public var syncButton: UIButton! {
        didSet {
            syncButton.tintColor = theme.colours.primaryColor
        }
    }
    
    @IBOutlet public var controlsContainer: UIView! {
        didSet {
            controlsContainer.layer.cornerRadius = 10.0
        }
    }
    
    @IBOutlet weak var map: MKMapView! {
        didSet {
            map.showsUserLocation = true
            map.mapType = .standard
            map.userTrackingMode = .follow
        }
    }
}
