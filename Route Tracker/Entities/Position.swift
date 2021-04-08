//
//  Position.swift
//  Route Tracker
//
//  Created by Aksilont on 08.04.2021.
//

import Foundation
import RealmSwift

final class Position: Object {
    @objc dynamic var latitude: Double
    @objc dynamic var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    override init() {
        latitude = 0.0
        longitude = 0.0
    }
}
