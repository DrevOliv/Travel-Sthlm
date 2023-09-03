//
//  LocationManager.swift
//  Auto Resa
//
//  Created by Oliver Drevet on 2022-02-23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    
    private let locationManager = CLLocationManager()
    @Published var userlocation: CLLocation?
    static let shered = LocationManager()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    
    func requestLocation() {
        
        locationManager.requestWhenInUseAuthorization()

    }
    
    
    
    
}


extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            print("Not Determend")
        case .restricted:
            print("Restricted")
        case .denied:
            print("Denied")
        case .authorizedAlways:
            print("Always")
        case .authorizedWhenInUse:
            print("In Use")
        case .authorized:
            print("Ath")
        @unknown default:
            print("unknown")
        }
        
        
        
        LocationState.defaultValue = status.rawValue
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userlocation = location
    }
    
}
