//
//  LoginView.swift
//  challenge
//
//  Created by Thành Đỗ Long on 03/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit

public final class LoginView: UIView {
    private let theme = Theme()
    
    @IBOutlet public var loginButton: UIButton! {
        didSet {
            loginButton.layer.cornerRadius = 5
        }
    }
    
    func isLoginButtonEnabled(_ isEnabled: Bool){
        if isEnabled {
            loginButton.isEnabled = true
            loginButton.alpha = 1.0
            loginButton.setTitle("LOGIN", for: .normal)
        } else {
            loginButton.isEnabled = false
            loginButton.alpha = 0.5
            loginButton.setTitle("LOADING", for: .normal)
        }
    }

    @IBOutlet public var closeButton: UIButton!
    
    @IBOutlet public var emailTextField: UITextField! {
        didSet {
            emailTextField.layer.shadowColor = theme.colours.primaryColor.cgColor
            emailTextField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            emailTextField.layer.shadowOpacity = 1.0
            emailTextField.layer.shadowRadius = 0.0
        }
    }
    
    @IBOutlet public var passwordTextField: UITextField! {
        didSet {
            passwordTextField.layer.shadowColor = theme.colours.primaryColor.cgColor
            passwordTextField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            passwordTextField.layer.shadowOpacity = 1.0
            passwordTextField.layer.shadowRadius = 0.0
        }
    }
}
