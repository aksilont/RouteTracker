//
//  User.swift
//  Route Tracker
//
//  Created by Aksilont on 11.04.2021.
//

import Foundation
import RealmSwift

final class User: Object {
    @objc dynamic var login: String
    @objc dynamic var password: String
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
    
    override init() {
        login = "admin"
        password = "123"
    }
    
    override class func primaryKey() -> String? {
        return "login"
    }
}
