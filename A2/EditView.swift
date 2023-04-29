//
//  EditView.swift
//  A2
//
//  Created by Isaac Pollack on 14/4/2023.
//

import SwiftUI

struct EditView: View {
    ///Extracted view to remove bloat from ContentView. Contains functionality for editing/resetting/undoing name changes.
    @Binding var item: String
    @State var displayItem: String = ""
    @Environment(\.editMode) var editMode //Track whether we are editing or not

    var body: some View {
        VStack {
            if(editMode?.wrappedValue == .active) { // If edit mode is ACTIVE
                HStack {
                    Image(systemName: "square.and.pencil")
                    TextField("Input:", text: $displayItem)
                    Button("Cancel") {
                        displayItem = item
                    }
                    .onAppear {
                        //Set initial value to below preview/binded 'name'
                        displayItem = item
                    }
                    .onDisappear {
                        //When we leave the view; set the name to the changed value
                        item = displayItem
                    }
                }
            }
        }
    }
}
