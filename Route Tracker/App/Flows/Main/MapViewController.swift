//
//  MapViewController.swift
//  Route Tracker
//
//  Created by Aksilont on 04.04.2021.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    private let coordinateMoscow = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    
    private var backgroundTask: UIBackgroundTaskIdentifier?
    private var locationManager: CLLocationManager?
    
    private var manualMarker: GMSMarker?
    
    private var route: GMSPolyline?
    private var routePath: GMSMutablePath?
    private var routeForSave: Route?
    
    private var isTracking: Bool = false
    
    @IBOutlet weak var mapView: GMSMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    
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

    private func configureMap() {
        setCamera(to: coordinateMoscow)
    }
    
    private func configureLocationManager() {
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
        isTracking = true
    }
    
    @IBAction func stopTracking(_ sender: Any) {
        locationManager?.stopUpdatingLocation()
        isTracking = false
        
        saveRoute()
        routeForSave = nil
        
        guard let backgroundTask = self.backgroundTask else { return }
        UIApplication.shared.endBackgroundTask(backgroundTask)
        self.backgroundTask = .invalid
    }
    
    @IBAction func currentLocation(_ sender: Any) {
        locationManager?.requestLocation()
    }
    
    @IBAction func loadLastRoute(_ sender: Any) {
        locationManager?.stopUpdatingLocation()
        isTracking = false
        routeForSave = nil
        
        let results = RealmService.shared.get(Route.self)
        guard let lastRoute = results?.last else { return }
        
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        lastRoute.routePath.forEach { postion in
            routePath?.add(
                CLLocationCoordinate2D.init(latitude: postion.latitude,
                                            longitude: postion.longitude)
            )
        }
        route?.path = routePath
        route?.map = mapView
        
        if let routePath = routePath {
            let update = GMSCameraUpdate.fit(GMSCoordinateBounds(path: routePath))
            mapView.animate(with: update)
        }
    }
    
    private func setCamera(to coordinate: CLLocationCoordinate2D) {
        mapView.animate(to: GMSCameraPosition.camera(withTarget: coordinate, zoom: 17))
    }
    
    private func saveRoute() {
        if let routeForSave = routeForSave {
            RealmService.shared.deleteAll()
            RealmService.shared.save([routeForSave])
        }
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
        
        if isTracking {
            routePath?.add(location.coordinate)
            route?.path = routePath
            routeForSave?.addPosition(with: location.coordinate)
        }
        
        setCamera(to: location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
