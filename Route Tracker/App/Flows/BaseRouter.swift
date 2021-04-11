//
//  BaseRouter.swift
//  Route Tracker
//
//  Created by Aksilont on 11.04.2021.
//

import UIKit

class BaseRouter: NSObject {
    
    @IBOutlet weak var controller: UIViewController!
    
    func perform<Controller: UIViewController>(
        segue: String,
        performanceAction: ((Controller) -> Void)? = nil) {
        
        let performanceAction = performanceAction.map { action in
            { (controller: UIViewController) in
                guard let controller = controller as? Controller
                else {
                    assertionFailure("Waiting \(Controller.self)")
                    return
                }
                action(controller)
            }
        }
        
        controller?.performSegue(withIdentifier: segue, sender: performanceAction)
    }
    
    func prepare(for segue: UIStoryboardSegue,
                 sender: Any?) {
        guard let action = sender as? ((UIViewController) -> Void)
        else { return }
        action(segue.destination)
    }
    
}
