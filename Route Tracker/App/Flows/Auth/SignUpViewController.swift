//
//  SignUpViewController.swift
//  Route Tracker
//
//  Created by Aksilont on 12.04.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func singUpDidTap(_ sender: Any) {
        guard
            let login = loginTextField.text,
            let password = passwordTextField.text
        else { return }
        
        if let user = RealmService.shared.get(User.self, with: login) {
            user.password = password
            RealmService.shared.save([user])
        } else {
            RealmService.shared.save([User(login: login, password: password)])
        }
    }
    
    @IBAction func cancelDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
