//
//  RootSegue.swift
//  Route Tracker
//
//  Created by Aksilont on 11.04.2021.
//

import UIKit

class RootSegue: UIStoryboardSegue {
    override func perform() {
        UIApplication.shared.windows.first?.rootViewController = destination
    }
}
