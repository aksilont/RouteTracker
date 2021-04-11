//
//  LaunchViewController.swift
//  Route Tracker
//
//  Created by Aksilont on 11.04.2021.
//

import UIKit

class LaunchViewController: UIViewController {
    
    @IBOutlet weak var router: LaunchRouter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "isLogin") {
            router.toMain()
        } else {
            router.toAuth()
        }
    }
    
}

final class LaunchRouter: BaseRouter {
    
    func toMain() {
        perform(segue: "toMain")
    }
    
    func toAuth() {
        perform(segue: "toAuth")
    }
    
}
