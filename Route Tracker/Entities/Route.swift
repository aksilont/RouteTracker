//
//  Route.swift
//  Route Tracker
//
//  Created by Aksilont on 07.04.2021.
//

import Foundation
import RealmSwift
import CoreLocation

final class Route: Object {
    @objc dynamic var id: String = UUID.init().uuidString
    let routePath = List<Position>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func addPosition(with coordinate: CLLocationCoordinate2D) {
        routePath.append(Position(latitude: coordinate.latitude, longitude: coordinate.longitude))
    }
}
