//
//  LocationManager.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 27/9/2023.
//

import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        userLocation = locationManager.location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocation = location
        }
    }
}
