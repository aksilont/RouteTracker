//
//  MainViewController.swift
//  Route Tracker
//
//  Created by Aksilont on 11.04.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var onMap: ((String) -> Void)?
    var onLogout: (() -> Void)?
    
    @IBAction func showMapDidTap(_ sender: Any) {
        onMap?("testing")
    }
    
    @IBAction func logoutDidTap(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        onLogout?()
    }
    
}
