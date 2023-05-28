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

/// The LocManager class is responsible for managing the user's location and updating the region for the map.
/// The class adopts the CLLocationManagerDelegate and ObservableObject protocols.
/// The @Published property wrapper is used for the region property, which represents the map's coordinate region.
/// The manager property is an instance of CLLocationManager that manages location updates.
/// In the init() method, the manager's delegate is set to self, and location updates are requested when the app is in use. The manager also starts updating the location.
/// The delta constant represents the longitude and latitude delta for the map's region.
/// The locationManager(_:didUpdateLocations:) method is called when the location manager updates the user's location.
/// Inside the method, the latest location coordinate is extracted from the locations array using optional chaining (locations.last.map { loc in ... }).
/// The region's center latitude and longitude are updated with the latest coordinate, and the update is wrapped in a withAnimation block to animate the change.

/// Overall, this code sets up a LocManager class that manages the user's location and provides the region for the map view. It uses the CLLocationManagerDelegate to receive location updates and updates the region property accordingly. The @Published property wrapper allows for observing changes to the region property.
