//
//  MainCoordinator.swift
//  Route Tracker
//
//  Created by Aksilont on 12.04.2021.
//

import UIKit

class MainCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showMainModule()
    }
    
    private func showMainModule() {
        let controller = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(MainViewController.self)
        
        controller.onMap = { [weak self] uselsess in
            self?.showMapModule(useless: uselsess)
        }
        
        controller.onLogout = { [weak self] in
            self?.onFinishFlow?()
        }
        
        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }
    
    private func showMapModule(useless: String) {
        let controller = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(MapViewController.self)
        controller.uselessExample = useless
        rootController?.pushViewController(controller, animated: true)
    }
}
