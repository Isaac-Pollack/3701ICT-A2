//
//  LocationView.swift
//  A2
//
//  Created by Isaac Pollack on 13/5/2023.
//

import SwiftUI
import MapKit

struct LocationView: View {
    var body: some View {
        Map(coordinateRegion: $manager.region,
            showsUserLocation: true)
    }
}
