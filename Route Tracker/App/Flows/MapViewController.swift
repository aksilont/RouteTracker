//
//  MapViewController.swift
//  Route Tracker
//
//  Created by Aksilont on 04.04.2021.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    let coordinateMoscow = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    
    var backgroundTask: UIBackgroundTaskIdentifier?
    var locationManager: CLLocationManager?
    
    var manualMarker: GMSMarker?
    
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    var routeForSave: Route?
    
    lazy var realm = RealmService()
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            guard let backgroundTask = self?.backgroundTask else { return }
            UIApplication.shared.endBackgroundTask(backgroundTask)
            self?.backgroundTask = .invalid
        }
        
        configureMap()
        configureLocationManager()
    }

    func configureMap() {
        mapView.delegate = self
        setCamera(to: coordinateMoscow)
    }
    
    func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.pausesLocationUpdatesAutomatically = false
        locationManager?.startMonitoringSignificantLocationChanges()
        locationManager?.requestAlwaysAuthorization()
    }
    
    @IBAction func startTracking(_ sender: Any) {
        route?.map = nil
        
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView
        
        routeForSave = Route()
        
        locationManager?.startUpdatingLocation()
    }
    
    @IBAction func stopTracking(_ sender: Any) {
        locationManager?.stopUpdatingLocation()
        
        if let routeForSave = routeForSave {
            realm.saveToRealm([routeForSave], deleteAll: true)
        }
        routeForSave = nil
        
        guard let backgroundTask = self.backgroundTask else { return }
        UIApplication.shared.endBackgroundTask(backgroundTask)
        self.backgroundTask = .invalid
    }
    
    @IBAction func currentLocation(_ sender: Any) {
        locationManager?.requestLocation()
    }
    
    private func setCamera(to coordinate: CLLocationCoordinate2D) {
        mapView.animate(to: GMSCameraPosition.camera(withTarget: coordinate, zoom: 17))
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if let manualMarker = manualMarker {
            manualMarker.position = coordinate
        } else {
            let marker = GMSMarker(position: coordinate)
            marker.map = mapView
            self.manualMarker = marker
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        routePath?.add(location.coordinate)
        route?.path = routePath
        
        setCamera(to: location.coordinate)
        
        let newPostion = Position()
        newPostion.latitude = location.coordinate.latitude
        newPostion.longitude = location.coordinate.longitude
        routeForSave?.routePath.append(newPostion)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
