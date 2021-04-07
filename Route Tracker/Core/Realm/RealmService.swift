//
//  RealmService.swift
//  Route Tracker
//
//  Created by Aksilont on 07.04.2021.
//

import Foundation
import RealmSwift

class RealmService {
    
    func saveToRealm<T: Object>(_ objects: [T], deleteAll: Bool = false) {
        do {
            let realm = try Realm()
            try realm.write {
                if deleteAll { realm.deleteAll() }
                realm.add(objects, update: .all)
            }
        } catch {
            print(error)
        }
    }
}
