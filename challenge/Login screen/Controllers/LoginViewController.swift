//
//  LoginViewController.swift
//  challenge
//
//  Created by Thành Đỗ Long on 03/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    private let safariController = SafariController()
    private let locationAPI: LocationAPI = LocationAPI()
    
    var loginView: LoginView! {
        guard isViewLoaded else { return nil }
        return (view as! LoginView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        guard let url = URL(string: "https://fiesta.esncz.org/password/forgot/") else {
            return
        }
        safariController.openUrl(url: url)
    }
    
    @IBAction func signup(_ sender: UIButton) {
        guard let url = URL(string: "https://fiesta.esncz.org/setup") else {
            return
        }
        safariController.openUrl(url: url)
    }
    
    static func storyboardInit() -> UIViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()!
        return viewController
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func login() {
        guard let email = loginView.emailTextField.text, !email.isEmpty else {
            return showAlert(withTitle: nil, message: "The email is incorrect.")
        }
        
        guard let password = loginView.passwordTextField.text, !password.isEmpty else {
            return showAlert(withTitle: nil, message: "The password is incorrect.")
        }
        
        loginView.isLoginButtonEnabled(false)
        
        locationAPI.login(email: email, password: password) { (data, error) in
            self.loginView.isLoginButtonEnabled(true)
            
            guard let data = data as? [String: String] else {
                return self.showAlert(withTitle: nil, message: error?.errorMessages ?? "Unknown error. Please, try it again later.")
            }
            
            Default.accessToken = data["access_token"]
        }
    }
}
