//
//  BaseRouter.swift
//  Route Tracker
//
//  Created by Aksilont on 11.04.2021.
//

import UIKit

class BaseRouter: NSObject {
    
    @IBOutlet weak var controller: UIViewController!
    
    func show(_ controller: UIViewController) {
        self.controller.show(controller, sender: nil)
    }
    
    func present(_ controller: UIViewController) {
        self.controller.present(controller, animated: true)
    }
    
    func setAsRoot(_ controller: UIViewController) {
        UIApplication.shared.windows.first?.rootViewController = controller
    }
    
}
