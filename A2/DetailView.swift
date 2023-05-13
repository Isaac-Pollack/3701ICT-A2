//
//  DetailView.swift
//  A2
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI
import MapKit

struct DetailView: View {
    /// Here we are visualising the specific data for one instance of Place, and whether we are in edit mode. We also asynchronously request the image value saved to it.
    @Environment(\.editMode) var editMode
    @ObservedObject var place: Place
    @StateObject var manager = LocManager()
    
    //Object States
    @State var name: String = ""
    @State var details: String = ""
    @State var url: String = ""
    @State var lat: String = ""
    @State var long: String = ""
    @State var image = Image(systemName: "photo")
    
    var body: some View {
        List {
            if (editMode?.wrappedValue == .active) {
                TextField("Enter the name of the place:", text: $name)
                TextField("Enter the details of the place:", text: $details)
                TextField("Enter the latitude of the place:", text: $lat)
                TextField("Enter the longitude of the place:", text: $long)
                TextField("Enter the image url of the place:", text: $url)
                    .onAppear {
                        name = place.strName
                        details = place.strDetails
                        url = place.strUrl
                        lat = place.strLatitude
                        long = place.strLongitude
                    }.onDisappear {
                        if (editMode?.wrappedValue != .active) {
                            place.strName = name
                            place.strDetails = details
                            place.strUrl = url
                            place.strLatitude = lat
                            place.strLongitude = long
                            place.save()
                        }
                    }
            } else {
                image.resizable().aspectRatio(contentMode: .fit)
                Text(place.strDetails)
                Text("Latitude: " + place.strLatitude)
                Text("Longitude: " + place.strLongitude)
                NavigationLink {
                    MapView(place: place)
                        .navigationBarItems(leading: EditButton())
                } label: {
                    HStack{
                        Map(coordinateRegion: $manager.region, showsUserLocation: true).frame(width: 40, height: 40)
                        Text("Map of \(place.strName)")
                    }
                }
            }
        }
        .navigationTitle(place.strName)
        .task {
            await image = place.getImage()
        }
    }
}
