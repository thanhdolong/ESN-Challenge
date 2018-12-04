//
//  SwinjectStoryboard+Extension.swift
//  challenge
//
//  Created by Thành Đỗ Long on 10/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation

import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration
import CoreLocation
import RealmSwift

extension SwinjectStoryboard {
    @objc class func setup() {
        Container.loggingFunction = nil
        defaultContainer.register(Database.self) { _ in Database() }
        
        defaultContainer.register(MapDatasource.self) { (resolver) -> MapDatasource in
            let database = resolver.resolve(Database.self)!
            return MapDatasource(database: database)
        }
        
        defaultContainer.autoregister(CLLocationManager.self, initializer: CLLocationManager.init)
        defaultContainer.autoregister(MapDatasource.self, argument: Database.self, initializer: MapDatasource.init(database:))

        
        defaultContainer.storyboardInitCompleted(MapViewController.self) { resolver, controller in
            controller.mapScreenDatasource = resolver ~> MapDatasource.self
            controller.locationManager = resolver ~> CLLocationManager.self
        }
        
//        defaultContainer.storyboardInitCompleted(MapScreenViewController.self) { resolver, controller in
//            controller.mapScreenDatasource = resolver ~> MapScreenDatasource.self
//            controller.locationManager = resolver ~> CLLocationManager.self
//        }
    }
}
