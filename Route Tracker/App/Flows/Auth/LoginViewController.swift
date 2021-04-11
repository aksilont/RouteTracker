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
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var router: LoginRouter!
    
    @IBAction func loginDidTap(_ sender: Any) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              login == Constants.login, password == Constants.password
        else { return }
        
        UserDefaults.standard.set(true, forKey: "isLogin")
        
        router.toMain()
    }
    
    @IBAction func recoveryDidTap(_ sender: Any) {
        router.onRecovery()
    }
}

final class LoginRouter: BaseRouter {
    
    func toMain() {
        perform(segue: "toMain")
    }
    
    func onRecovery() {
        perform(segue: "onRecovery")
    }
    
}
