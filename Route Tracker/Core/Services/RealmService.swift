//
//  RealmService.swift
//  Route Tracker
//
//  Created by Aksilont on 07.04.2021.
//

import Foundation
import RealmSwift

class RealmService {
    
    static let shared = RealmService()
    
    private var realm: Realm?
    
    private init() {
        realm = try? Realm()
    }
    
    func get<T: Object>(_ type: T.Type) -> Results<T>? {
        return realm?.objects(type)
    }
    
    func save<T: Object>(_ objects: [T]) {
        do {
            try realm?.write {
                realm?.add(objects, update: .all)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteAll() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            print(error)
        }
    }
    
    func delete<T: Object>(_ objects: [T]) {
        do {
            try realm?.write {
                realm?.delete(objects)
            }
        } catch {
            print(error)
        }
    }
}
