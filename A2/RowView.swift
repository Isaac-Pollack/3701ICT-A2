//
//  RowView.swift
//  A2
//
//  Created by Isaac Pollack on 20/3/2023.
//

import Foundation
import SwiftUI

struct RowView: View {
    var animal:Animal
    @State var image = defaultImage
    var body: some View {
        HStack{
            image.frame(width: 40, height: 40).clipShape(Circle())
            Text(animal.rowDisplay)
        }
        .task {
            image = await animal.getImage()
        }
    }
}
