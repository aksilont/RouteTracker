//
//  RecoveryPasswordViewController.swift
//  Route Tracker
//
//  Created by Aksilont on 11.04.2021.
//

import UIKit

class RecoveryPasswordViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBAction func recoveryDidTap(_ sender: Any) {
        guard
            let login = loginTextField.text,
            login == LoginViewController.Constants.login
        else { return }
        
        showPassword()
    }
    
    private func showPassword() {
        let alertController = UIAlertController(title: "Password",
                                                message: "123",
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true)
        
    }
}
