//
//  ListView.swift
//  A2
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI

struct ListView: View {
    //Parent Checklist
    @Binding var list: ChecklistDataModel
    @State var checklistName: String = ""
    @State var displayName = ""

    //Sub-Item/s
    @Environment(\.editMode) var editMode // Another edit mode tracker, is it active?
    var count: Int
    @State var itemMarked = false // Is the item ticked?
    @State var newItem = ""
    @State var checklistItems: [[String]] = []
    @State var tempList: [[String]] = []

    var body: some View {
        if(editMode?.wrappedValue == .inactive) {
            EditView(item: $checklistName)
            HStack {
                TextField("Add Item:", text: $newItem)
                Button(action: {
                    tempList.append([newItem, "square"])
                    newItem = ""
                }) {
                    Text("+")
                }
            }
        }

            List {
                ForEach($tempList, id:\.self) { $item in
                    HStack {
                        Text(item[0])
                        Spacer()
                        Image(systemName: "\(item[1])")
                    }
                    .onTapGesture {
                        /// If the second value in the checklist items array is ticked, and we click it, then it gets changed to unticked.
                        if(item[1] == "checkmark.square.fill") {
                            item[1] = "square"
                        }
                        else {
                            /// Reverse of the above
                            item[1] = "checkmark.square.fill"
                        }
                    }
                }
                .onDelete { indices in
                    tempList.remove(atOffsets: indices)
                }
                .onMove { indices, i in
                    tempList.move(fromOffsets: indices, toOffset: i)
                }
            }
        .navigationTitle("\(checklistName)")
        .navigationBarItems(
            leading:
                Button(action: {
                    if itemMarked {
                        //Reset button
                        tempList = checklistItems
                        itemMarked.toggle()
                    } else {
                        //Undo Button
                        checklistItems = tempList
                        tempList = tempList.map{ [$0[0], "square"] }
                        itemMarked.toggle()
                    }
                }) {
                    if(editMode?.wrappedValue == .active) {
                        Text(itemMarked ? "Reset" : "Undo")
                    }
                },
            trailing:
                HStack {
                    Button(action: {
                        //Save button
                        list.checklists[count].items = tempList
                        checklistItems = tempList
                        list.saveChecklists()
                    }) {
                        if(editMode?.wrappedValue == .active) {
                            Text("Save")
                        }
                    }
                    EditButton()
                }
        )
        .onAppear {
            checklistName = list.checklists[count].name
            checklistItems = list.checklists[count].items
            tempList = list.checklists[count].items
        }
        .onDisappear {
            list.checklists[count].name = checklistName
            list.checklists[count].items = checklistItems
        }
        .padding()
    }
}
