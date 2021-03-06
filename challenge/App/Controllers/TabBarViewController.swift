//
//  TabBarViewController.swift
//  challenge
//
//  Created by Thành Đỗ Long on 18/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initItems()
    }
    

    private func initItems() -> Void {
        // 1.
        let firstVC = embedControllerToNavigationController(vc: LeaderboardsViewController(database: Database()))
        let secondVC = MapViewController.storyboardInit()
        let thirdVC = ProfileContainerViewController(user: Token())
        
        
        let firstTaBBarItem = UITabBarItem(title: "HIGH SCORES",
                                           image: UIImage(named: "score"),
                                           selectedImage: UIImage(named: "score"))
        let secondTaBBarItem = UITabBarItem(title: "MAP",
                                            image: UIImage(named: "map"),
                                            selectedImage: UIImage(named: "map"))
        let thirdTaBBarItem = UITabBarItem(title: "PROFILE", image: UIImage(named: "profile"),
                                           selectedImage: UIImage(named: "profile"))
        
        firstVC.tabBarItem = firstTaBBarItem
        secondVC.tabBarItem = secondTaBBarItem
        thirdVC.tabBarItem = thirdTaBBarItem
        let theme = Theme()
    
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: theme.fonts.tapBarTitle], for: .normal)
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = true
        self.tabBar.tintColor = UIColor(red: 252, green: 116, blue: 34)
        self.tabBar.layer.backgroundColor = UIColor(red: 255, green: 255, blue: 255).withAlphaComponent(0).cgColor
        
        self.viewControllers = [firstVC, secondVC, thirdVC]
        
        self.selectedIndex = 1
    }
    
    
    func embedControllerToNavigationController(vc: UIViewController) -> NavigationController {
        let navigationController = NavigationController(rootViewController: vc)
        return navigationController
    }

}
