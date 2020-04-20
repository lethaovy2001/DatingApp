//
//  LocationService.swift
//  DatingApp
//
//  Created by Vy Le on 4/19/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import CoreLocation
import UIKit

class LocationService {
    private var locationManager: CLLocationManager?
    private var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        locationManager?.delegate = viewController as? CLLocationManagerDelegate
        locationManager?.allowsBackgroundLocationUpdates = false
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = 1609
    }
    
    func didUpdateLocations(locations: [CLLocation]) {
        if let location = locations.last {
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
        }
    }
    
    func didChangeAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
           break
        case .denied, .restricted, .notDetermined:
           break
        default:
            break
        }
    }
}



