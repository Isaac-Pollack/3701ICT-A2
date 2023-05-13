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
