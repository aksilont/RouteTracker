//
//  MapViewController.swift
//  Route Tracker
//
//  Created by Aksilont on 04.04.2021.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    let coordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    
    var marker: GMSMarker?
    var manualMarker: GMSMarker?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMap()
    }

    func configureMap() {
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
        mapView.camera = camera
        mapView.delegate = self
    }
    
    @IBAction func goToRedSquare(_ sender: Any) {
        mapView.animate(toLocation: coordinate)
    }
    
    @IBAction func toggleMarker(_ sender: Any) {
        if marker == nil {
            addMarker()
        } else {
            removeMarker()
        }
    }
    
    private func addMarker() {
        let marker = GMSMarker(position: coordinate)
        marker.title = "This is"
        marker.snippet = "Red Square"
        marker.map = mapView
        self.marker = marker
    }
    
    private func removeMarker() {
        marker?.map = nil
        marker = nil
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
