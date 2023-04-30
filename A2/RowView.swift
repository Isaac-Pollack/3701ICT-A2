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
