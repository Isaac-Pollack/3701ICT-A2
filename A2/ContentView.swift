//
//  ContentView.swift
//  A2
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            /// KISS method here, seperate all of our concerns out of the ContentView.
            PlaceListView()
        }
    }
}
