//
//  MapLoc.swift
//  A2
//
//  Created by Isaac Pollack on 13/5/2023.
//

import UIKit
import MapKit

struct MapLoc: Identifiable {
    
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coord: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

let MyLocs = [
    MapLoc(name: "Brisbane City Markets", latitude: -27.47105139, longitude: 153.02282738),
    MapLoc(name: "Brisbane Square", latitude: -27.47046702046, longitude: 153.0227359047),
    MapLoc(name: "The Myer Centre", latitude: -27.470621231125, longitude: 153.0247941551),
]
