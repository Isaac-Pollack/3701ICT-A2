//
//  MapView.swift
//  A2
//
//  Created by Isaac Pollack on 13/5/2023.
//

import SwiftUI
import MapKit

struct MapView: View {

    @Environment(\.editMode) var editMode
    @ObservedObject var place: Place

    @State var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -27.470, longitude: 153.022), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))

    var body: some View {
        NavigationView {
            VStack {
                Map(coordinateRegion: $region, showsUserLocation: true)

                if (editMode?.wrappedValue == .active) {
                    TextField("Enter the latitude:", text: $place.strLatitude)
                    TextField("Enter the longitude:", text: $place.strLongitude)
                } else {
                    Text("Latitude: " + place.strLatitude)
                    Text("Longitude: " + place.strLongitude)
                }
            }
        }
        .padding()
        .navigationTitle("Map of " + place.strName)
    }
}

/// The MapView struct represents a view that displays a map and information about a place.
/// The @Environment(\.editMode) property wrapper allows accessing the edit mode environment variable.
/// The @ObservedObject property wrapper is used to observe changes to the place object.
/// The @State property wrapper is used for the region property, which represents the map's coordinate region.
/// The body property defines the content of the view.
/// Inside the NavigationView and VStack, the Map view is displayed, using the coordinateRegion property bound to the region state.
/// The Map view also shows the user's location.
/// The content inside the if statement is conditionally displayed based on the edit mode.
/// When the edit mode is active, two TextField views allow the user to enter the latitude and longitude.
/// When the edit mode is not active, two Text views display the latitude and longitude of the place.
/// The view is padded and the navigation title is set to "Map of " followed by the name of the place.

/// Overall, this code sets up a view that displays a map, allows editing the latitude and longitude in edit mode, and shows the corresponding information in non-edit mode.
