//
//  ViewController.swift
//  test
//
//  Created by Thành Đỗ Long on 29/10/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit
import CoreLocation
import SwinjectStoryboard

class LeaderboardsViewController: UIViewController {
    var highScoresView: HighScoresView! {
        guard isViewLoaded else { return nil }
        return (view as! HighScoresView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    static func storyboardInit() -> UIViewController {
        let storyboard = UIStoryboard(name: "HighScores", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()! 
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
    @IBAction func showMap(_ sender: UIButton) {
        print("show map")
        let viewController = MapViewController.storyboardInit()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func logout(_ sender: UIButton) {
        let user = Token()
        user.deleteAccessToken()
    }
}

