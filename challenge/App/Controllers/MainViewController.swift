//
//  ViewController.swift
//  test
//
//  Created by Thành Đỗ Long on 29/10/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
    @IBAction func showMap(_ sender: UIButton) {
        print("show map")
        let viewController = MapScreenViewController.initFromStoryboard()
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}

