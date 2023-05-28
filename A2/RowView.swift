//
//  RowView.swift
//  A2
//
//  Created by Isaac Pollack on 20/3/2023.
//

import Foundation
import SwiftUI

struct RowView: View {
    @ObservedObject var place : Place
    @State var image = Image(systemName: "photo")

    var body: some View {
        HStack{
            image.frame(width: 40, height: 40).clipShape(Circle())
            Text("\(place.strName)")
        }
        .task {
            image = await place.getImage()
        }
    }
}

/// The RowView struct has an ObservedObject property place which represents the place object to display information about.
/// The image state property is initialized with a default image (Image(systemName: "photo")).
/// The body property is a some View computed property that defines the content of the view.
/// Inside the HStack, an image is displayed with a size of 40x40 and a circular shape.
/// The text of the place's name is displayed next to the image.
/// The .task modifier is used to perform an asynchronous task, which fetches the image for the place using the getImage method from the Place extension.
/// When the image is fetched asynchronously, it updates the image state property, which triggers a view update and displays the fetched image.

/// Overall, this RowView is responsible for displaying a row of information about a place, including an image fetched asynchronously using the getImage method.
