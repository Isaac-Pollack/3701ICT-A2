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
