//
//  LoginViewController.swift
//  challenge
//
//  Created by Thành Đỗ Long on 03/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    func userLogged()
}

class LoginViewController: UIViewController {
    private let safariController = SafariController()
    private let api: ChallengeAPI = ChallengeAPI()
    private let token: Token = Token()
//    var profileViewController: ProfileViewController!
    var delegate: LoginViewControllerDelegate?
    
    var loginView: LoginView! {
        guard isViewLoaded else { return nil }
        return (view as! LoginView)
    }
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        guard let url = URL(string: "https://challenge.esncz.org/password/forgot/") else {
            return
        }
        safariController.openUrl(url: url)
    }
    
    @IBAction func signup(_ sender: UIButton) {
        guard let url = URL(string: "https://challenge.esncz.org/setup") else {
            return
        }
        safariController.openUrl(url: url)
    }
    
    static func storyboardInit() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! LoginViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    private func setupNavigation() {
        let settingsImage = UIImage(named: "settings")?.withRenderingMode(.alwaysTemplate)
        let settingsButton = UIBarButtonItem(image: settingsImage, style: .plain, target: self, action: #selector(openSettings))
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc func openSettings() {
        let vc = NavigationController(rootViewController: SettingsTableViewController.init())
        self.present(vc, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func login() {
        guard let email = loginView.emailTextField.text, !email.isEmpty else {
            return showAlert(withTitle: nil, message: "The email can not be empty.")
        }
        
        guard let password = loginView.passwordTextField.text, !password.isEmpty else {
            return showAlert(withTitle: nil, message: "The password can not be empty")
        }
        
        loginView.isLoginButtonEnabled(false)
        
        api.login(email: email, password: password) { (data, error) in
            self.loginView.isLoginButtonEnabled(true)
            
            guard let data = data as? [String: String] else {
                return self.showAlert(withTitle: nil, message: error?.errorMessages ?? "Unknown error. Please, try it again later.")
            }

            self.token.accessToken = data["access_token"]
            self.delegate?.userLogged()
        }
    }
}
