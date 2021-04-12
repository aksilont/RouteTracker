//
//  LoginViewController.swift
//  Route Tracker
//
//  Created by Aksilont on 09.04.2021.
//

import UIKit

final class LoginViewController: UIViewController {
    
    enum Constants {
        static let login = "admin"
        static let password = "123"
    }
    
    var onLogin: (() -> Void)?
    var onRecovery: (() -> Void)?
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginDidTap(_ sender: Any) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              login == Constants.login, password == Constants.password
        else { return }
        
        UserDefaults.standard.set(true, forKey: "isLogin")
        
        onLogin?()
    }
    
    @IBAction func recoveryDidTap(_ sender: Any) {
        onRecovery?()
    }
}
