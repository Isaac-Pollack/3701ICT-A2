//
//  DetailView.swift
//  A2
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.editMode) var editMode
    @ObservedObject var place: Place
    
    @State var name: String = ""
    @State var url: String = ""
    @State var lat: String = ""
    @State var long: String = ""
    @State var image = Image(systemName: "photo")
    
    var body: some View {
        List {
            if (editMode?.wrappedValue == .active) {
                TextField("Enter the name of the place:", text: $name)
                TextField("Enter the latitude of the place:", text: $lat)
                TextField("Enter the longitude of the place:", text: $long)
                TextField("Enter the image url of the place:", text: $url)
                    .onAppear {
                        name = place.strName
                        url = place.strUrl
                        lat = place.strLatitude
                        long = place.strLongitude
                }.onDisappear {
                    if (editMode?.wrappedValue != .active) {
                        place.strName = name
                        place.strUrl = url
                        place.strLatitude = lat
                        place.strLongitude = long
                        place.save()
                    }
                }
            } else {
                Text("Name: " + place.strName)
                Text("Latitude: " + place.strLatitude)
                Text("Longitude: " + place.strLongitude)
                image.resizable().aspectRatio(contentMode: .fit)
            }
        }
        .navigationTitle(place.strName)
        .task {
            await image = place.getImage()
        }
    }
}
