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
        
        defaultContainer.register(MapScreenDatasource.self) { (resolver) -> MapScreenDatasource in
            let database = resolver.resolve(Database.self)!
            return MapScreenDatasource(database: database)
        }
        
        defaultContainer.autoregister(CLLocationManager.self, initializer: CLLocationManager.init)
        defaultContainer.autoregister(MapScreenDatasource.self, argument: Database.self, initializer: MapScreenDatasource.init(database:))

        
        defaultContainer.storyboardInitCompleted(MapScreenViewController.self) { resolver, controller in
            controller.mapScreenDatasource = resolver ~> MapScreenDatasource.self
            controller.locationManager = resolver ~> CLLocationManager.self
        }
        
//        defaultContainer.storyboardInitCompleted(MapScreenViewController.self) { resolver, controller in
//            controller.mapScreenDatasource = resolver ~> MapScreenDatasource.self
//            controller.locationManager = resolver ~> CLLocationManager.self
//        }
    }
}
