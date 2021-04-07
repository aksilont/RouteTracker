//
//  Route.swift
//  Route Tracker
//
//  Created by Aksilont on 07.04.2021.
//

import Foundation
import RealmSwift
import CoreLocation

final class Position: Object {
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
}

final class Route: Object {
    @objc dynamic var id = 0
    let routePath = List<Position>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
