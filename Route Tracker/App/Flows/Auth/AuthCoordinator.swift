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
            self?.showRecoveryModel()
        }
        
        controller.onLogin = { [weak self] in
            self?.onFinishFlow?()
        }
        
        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }
    
    private func showRecoveryModel() {
        let controller = UIStoryboard(name: "Auth", bundle: nil)
            .instantiateViewController(RecoveryPasswordViewController.self)
        rootController?.pushViewController(controller, animated: true)
    }
}
