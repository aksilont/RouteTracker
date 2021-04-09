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
    
    var locationManager: CLLocationManager?
    lazy var geocoder: CLGeocoder = {
        return CLGeocoder()
    }()
    
    var manualMarker: GMSMarker?
    var markers: [GMSMarker?] = [] {
        didSet {
            if markers.count > 20 {
                markers[0]?.map = nil
                markers[0] = nil
                markers.remove(at: 0)
            }
        }
    }
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        locationManager?.requestWhenInUseAuthorization()
    }
    
    @IBAction func startTracking(_ sender: Any) {
        locationManager?.startUpdatingLocation()
    }
    
    @IBAction func stopTracking(_ sender: Any) {
        locationManager?.stopUpdatingLocation()
    }
    
    @IBAction func currentLocation(_ sender: Any) {
        locationManager?.requestLocation()
    }
    
    private func addMarker(to coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.title = "\(Date())"
        marker.map = mapView
        markers.append(marker)
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
        
        addMarker(to: location.coordinate)
        setCamera(to: location.coordinate)
        
        geocoder.reverseGeocodeLocation(location) { (places, error) in
            print(places?.first ?? "no address")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
