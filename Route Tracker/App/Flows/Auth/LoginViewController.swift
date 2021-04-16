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
    
    lazy var secretView: SecretView = SecretView()
    
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
