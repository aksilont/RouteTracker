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
        
        if RealmService.shared.get(User.self, with: login) != nil {
            let alertController = UIAlertController(title: "Error",
                                                    message: "Login is busy. Do u wanna rewrite?",
                                                    preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                RealmService.shared.save([User(login: login, password: password)])
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
        } else {
            RealmService.shared.save([User(login: login, password: password)])
        }
    }
    
    @IBAction func cancelDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
