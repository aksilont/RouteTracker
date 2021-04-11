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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.prepare(for: segue, sender: sender)
    }
    
}

final class MainRouter: BaseRouter {
    
    func toMap(useless: String) {
        perform(segue: "toMap") { (controller: MapViewController) in
            controller.uselessExample = useless
        }
    }
    
    func toLaunch() {
        perform(segue: "toLaunch")
    }
}
