//
//  SignUpViewController.swift
//  Route Tracker
//
//  Created by Aksilont on 12.04.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
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
    
    lazy var secretView: SecretView = SecretView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSecretView()
    }
    
    private func setupSecretView() {
        secretView.frame = view.frame
        secretView.frame.origin.y -= secretView.frame.size.height
        view.addSubview(secretView)
        
        addObserver()
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self,
                             selector: #selector(appMovedToBackground),
                             name: UIApplication.willResignActiveNotification,
                             object: nil)
        NotificationCenter.default.addObserver(self,
                             selector: #selector(appBecomesActive),
                             name: UIApplication.didBecomeActiveNotification,
                             object: nil)
    }
    
    @objc func appMovedToBackground() {
        UIView.animate(withDuration: 1.0) {
            self.secretView.frame.origin.y += self.secretView.frame.size.height
            self.navigationController?.isNavigationBarHidden = true
        }
    }
    
    @objc func appBecomesActive() {
        UIView.animate(withDuration: 1.0) {
            self.secretView.frame.origin.y -= self.secretView.frame.size.height
            self.navigationController?.isNavigationBarHidden = false
        }
        passwordTextField.text = ""
    }
    
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
