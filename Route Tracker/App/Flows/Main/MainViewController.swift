//
//  MainViewController.swift
//  Route Tracker
//
//  Created by Aksilont on 11.04.2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBAction func showMapDidTap(_ sender: Any) {
        performSegue(withIdentifier: "toMap", sender: sender)
    }
    
    @IBAction func logoutDidTap(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        performSegue(withIdentifier: "toLaunch", sender: sender)
    }
}
