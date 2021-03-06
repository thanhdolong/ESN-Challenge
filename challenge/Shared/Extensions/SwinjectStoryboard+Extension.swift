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
        defaultContainer.register(Token.self) { _ in Token() }
        
        defaultContainer.register(LocationsDatasource.self) { (resolver) -> LocationsDatasource in
            let database = resolver.resolve(Database.self)!
            return LocationsDatasource(database: database)
        }
        
//        defaultContainer.register(ProfileViewModel.self) { (resolver) -> ProfileViewModel in
//            let database = resolver.resolve(Database.self)!
//            return ProfileViewModel(database: database)
//        }
        
        defaultContainer.register(ProfileViewController.self) { (resolver) -> ProfileViewController in
            let database = resolver.resolve(Database.self)!
            return ProfileViewController(database: database)
        }
        
        defaultContainer.autoregister(CLLocationManager.self, initializer: CLLocationManager.init)
        defaultContainer.autoregister(LocationsDatasource.self, argument: Database.self, initializer: LocationsDatasource.init(database:))

        defaultContainer.autoregister(ProfileViewModel.self, argument: Database.self, initializer: ProfileViewModel.init(database:))
        
        defaultContainer.storyboardInitCompleted(MapViewController.self) { resolver, controller in
            controller.locationsDatasource = resolver ~> LocationsDatasource.self
            controller.locationManager = resolver ~> CLLocationManager.self
        }
        
//        defaultContainer.storyboardInitCompleted(LoginViewController.self) { (resolver, controller) in
//            controller.profileViewController = resolver ~> ProfileViewController.self
//        }
//        defaultContainer.storyboardInitCompleted(MapScreenViewController.self) { resolver, controller in
//            controller.mapScreenDatasource = resolver ~> MapScreenDatasource.self
//            controller.locationManager = resolver ~> CLLocationManager.self
//        }
    }
}
