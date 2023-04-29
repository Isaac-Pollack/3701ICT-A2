//
//  ContentView.swift
//  A2
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct ContentView: View {
    @Binding var model: ChecklistDataModel //Our binded model
    @State var checklistTitle = "My Checklists" //Editable title state

    var body: some View {
        NavigationView() {
            VStack {
                EditView(item: $checklistTitle) //Seperation of concerns
                List {
                    ForEach(model.checklists.enumerated().map { $0 }, id: \.element) { (index, i) in
                        NavigationLink(destination: ListView(list: $model, count: index)) {
                            Text(i.name)
                            // Navlink and display name of each entry, mapped.
                        }
                    }
                    .onDelete { indices in
                        //Delete entry in list
                        model.checklists.remove(atOffsets: indices)
                        model.saveChecklists()
                    }
                    .onMove { indices, i in
                        // Moveable anywhere in list, not just hard-coded space (As previous)
                        model.checklists.move(fromOffsets: indices, toOffset: i)
                        model.saveChecklists()
                    }
                }.navigationTitle(checklistTitle) // Extracted to binding to make editable
                    .navigationBarItems(leading: EditButton(), trailing: Button("+"){
                        // Add new item with blank default
                        model.checklists.append(Checklist(name: "New List", items: [["New Item", "square"]]))
                    model.saveChecklists()
                })
            }
        }
        .padding()
    }
}
