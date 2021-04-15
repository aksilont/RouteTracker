//
//  LoginViewController.swift
//  Route Tracker
//
//  Created by Aksilont on 09.04.2021.
//

import UIKit

final class LoginViewController: UIViewController {
    
    var onLogin: (() -> Void)?
    var onRecovery: (() -> Void)?
    var onSignUp: (() -> Void)?
    
    @IBOutlet weak var loginTextField: UITextField! {
        didSet {
            loginTextField.autocorrectionType = .no
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
            passwordTextField.autocorrectionType = .no
        }
    }
    
    @IBAction func loginDidTap(_ sender: Any) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              let user = RealmService.shared.get(User.self, with: login),
              user.password == password
        else { return }
        
        UserDefaults.standard.set(true, forKey: "isLogin")
        
        onLogin?()
    }
    
    @IBAction func recoveryDidTap(_ sender: Any) {
        onRecovery?()
    }
    
    @IBAction func signUpDidTap(_ sender: Any) {
        onSignUp?()
    }
    
}
