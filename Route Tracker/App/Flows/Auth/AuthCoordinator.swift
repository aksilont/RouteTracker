//
//  AuthCoordinator.swift
//  Route Tracker
//
//  Created by Aksilont on 12.04.2021.
//

import UIKit

class AuthCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showLoginModule()
    }
    
    private func showLoginModule() {
        let controller = UIStoryboard(name: "Auth", bundle: nil)
            .instantiateViewController(LoginViewController.self)
        
        controller.onRecovery = { [weak self] in
            self?.showRecoveryModule()
        }
        
        controller.onSignUp = { [weak self] in
            self?.showSignUpModule()
        }
        
        controller.onLogin = { [weak self] in
            self?.onFinishFlow?()
        }
        
        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }
    
    private func showRecoveryModule() {
        let controller = UIStoryboard(name: "Auth", bundle: nil)
            .instantiateViewController(RecoveryPasswordViewController.self)
        rootController?.pushViewController(controller, animated: true)
    }
    
    private func showSignUpModule() {
        let controller = UIStoryboard(name: "Auth", bundle: nil)
            .instantiateViewController(SignUpViewController.self)
        rootController?.pushViewController(controller, animated: true)
    }
    
}
