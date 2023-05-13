//
//  LocManager.swift
//  A2
//
//  Created by Isaac Pollack on 13/5/2023.
//

import Foundation
import MapKit
import CoreLocation
import SwiftUI

// MAPPING
let delta = 10.0
class LocManager: NSObject, CLLocationManagerDelegate, ObservableObject {

    @Published var region = MKCoordinateRegion()
    
    let manager = CLLocationManager()
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        region.span.longitudeDelta = delta
        region.span.latitudeDelta = delta
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map{ loc in
            withAnimation {
                region.center.latitude = loc.coordinate.latitude
                region.center.longitude = loc.coordinate.longitude
            }
        }
    }
}

extension MyLocation {
    var coord: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func checkLocation(_ cb: @escaping (CLPlacemark?)->Void) {
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { marks, error in
            if let err = error {
                print("error in checkLocation \(err)")
                return
            }
            let mark = marks?.first
            cb(mark)
        }
    }
}
