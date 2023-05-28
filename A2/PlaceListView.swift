//
//  PlaceListView.swift
//  A2
//
//  Created by Liliana Barnard on 30/4/2023.
//

import SwiftUI

struct PlaceListView: View {
    /// Here we are tracking our changes to our instances of Place, grabbing and displaying each instances picture and name in a VStack, with user friendly thumbnails.
    /// We sort this list alphabetically.
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)], animation: .default)
    private var places: FetchedResults<Place>

    var body: some View {
        VStack {
            List {
                ForEach(places) { place in
                    NavigationLink {
                        DetailView(place: place)
                            .navigationBarItems(leading: EditButton())
                    } label: {
                        RowView(place: place)
                    }
                }.onDelete(perform: deletePlace)
            }
            .toolbar {
                ToolbarItem (placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem (placement: .navigationBarLeading) {
                    Button(action: addPlace) {
                        Label("Add Place", systemImage: "plus")
                    }
                }
            }
            Text("Select a Place")
        }.navigationTitle("Favourite Places")
            .onAppear{
                print("Number of places: \(places.count)")
            }
    }
}

extension PlaceListView {
    /// This extension is for seperating our functionality to do with CRUD methods on the instances of Place, setting default data on creation of a new instance, and allowing deletion.

    private func addPlace() {
        withAnimation {
            let newPlace = Place(context: viewContext)
            newPlace.strName = "New Place"
            newPlace.strUrl = ""
            newPlace.strDetails = "An interesting description!"
            newPlace.strLatitude = "0.0"
            newPlace.strLongitude = "0.0"

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deletePlace(offsets: IndexSet) {
        withAnimation {
            offsets.map { places[$0] }.forEach (viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

/// The PlaceListView struct represents a view that displays a list of favorite places.
/// The places property is fetched from Core Data using FetchRequest and sorted in ascending order by the name.
/// The body property defines the content of the view.
/// Inside the VStack, there's a List that iterates over the fetched places and displays each place using a NavigationLink wrapped in a RowView.
/// The onDelete modifier is added to enable deleting places from the list.
/// The toolbar items (EditButton and "Add Place" button) are added using the .toolbar modifier.
/// The Text view at the bottom displays a message when no place is selected.
/// The navigation title is set to "Favorite Places" using the navigationTitle modifier.
/// The .onAppear modifier is used to print the number of places when the view appears.
/// The addPlace function adds a new place to Core Data with default values.
/// The deletePlace function deletes the selected places from Core Data and saves the context.

/// Overall, this code sets up a view that displays a list of favorite places, allows adding and deleting places, and handles the navigation to the detail view.
