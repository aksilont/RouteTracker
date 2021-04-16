//
//  RecoveryPasswordViewController.swift
//  Route Tracker
//
//  Created by Aksilont on 11.04.2021.
//

import UIKit

class RecoveryPasswordViewController: UIViewController {
    
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
    }
    
    @IBOutlet weak var loginTextField: UITextField! {
        didSet {
            loginTextField.autocorrectionType = .no
        }
    }
    
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
