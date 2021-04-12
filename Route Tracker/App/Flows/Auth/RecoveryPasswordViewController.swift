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
            let user = RealmService.shared.get(User.self, with: login)
        else { return }
        
        showPassword(user.password)
    }
    
    private func showPassword(_ password: String) {
        let alertController = UIAlertController(title: "Password",
                                                message: password,
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
}
