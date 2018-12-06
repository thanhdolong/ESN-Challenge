//
//  ProfileViewController.swift
//  challenge
//
//  Created by Thành Đỗ Long on 06/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    private let user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Profile controler")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if user.accessToken == nil {
            print("Neni token")
            let login = LoginViewController.storyboardInit()
            self.definesPresentationContext = true
            login.modalPresentationStyle = .overCurrentContext
            login.modalTransitionStyle = .flipHorizontal
            self.present(login, animated: true, completion: nil)
            return
        }
        
       print("V pořádku")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
