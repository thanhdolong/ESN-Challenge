//
//  ProfileContainerViewController.swift
//  challenge
//
//  Created by Thành Đỗ Long on 05/01/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

class ProfileContainerViewController: UIViewController {
    
    private let user: Token
    private let containerView = UIView()
    
    lazy var loginViewController: UIViewController = {
        let loginVC = LoginViewController.storyboardInit()
        loginVC.view.frame = self.view.frame
        loginVC.delegate = self
        
        
        let loginVCEmbeded = NavigationController(rootViewController: loginVC)
        add(asChildViewController: loginVCEmbeded)
        return loginVCEmbeded
    }()
    
    lazy var profileViewController: UIViewController = {
        let profileVC = ProfileViewController(database: Database())
        profileVC.profileViewControllerDelegate = self
        let profileVCEmbeded = NavigationController(rootViewController: profileVC)
        profileVCEmbeded.view.frame = self.view.frame
        add(asChildViewController: profileVCEmbeded)
        return profileVCEmbeded
    }()
    
    
    init(user: Token) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addContainerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        user.isAccessTokenExist() ? setProfileScreen() : setLoginScreen()
    }
    
    func addContainerView() {
        containerView.frame = self.view.frame
        self.view.addSubview(containerView)
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    private func setLoginScreen() {
        remove(asChildViewController: profileViewController)
        add(asChildViewController: loginViewController)
    }
    
    private func setProfileScreen() {
        remove(asChildViewController: loginViewController)
        add(asChildViewController: profileViewController)
    }
}

extension ProfileContainerViewController: LoginViewControllerDelegate {
    func userLogged() {
        //present profile vc
        setProfileScreen()
    }
}

extension ProfileContainerViewController: profileViewControllerDelegate {
    func logoutPressed() {
        setLoginScreen()
    }
}


