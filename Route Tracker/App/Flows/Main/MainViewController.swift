//
//  MainViewController.swift
//  Route Tracker
//
//  Created by Aksilont on 11.04.2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var router: MainRouter!
    
    @IBAction func showMapDidTap(_ sender: Any) {
        router.toMap(useless: "Testing")
    }
    
    @IBAction func logoutDidTap(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        router.toLaunch()
    }
    
}

final class MainRouter: BaseRouter {
    
    func toMap(useless: String) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(MapViewController.self)
        controller.uselessExample = "testing"
        controller.modalPresentationStyle = .fullScreen
        show(controller)
    }
    
    func toLaunch() {
        let controller = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(LoginViewController.self)
        setAsRoot(UINavigationController(rootViewController: controller))
    }
}
