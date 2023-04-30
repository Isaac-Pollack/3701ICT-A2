//
//  PlaceListView.swift
//  A2
//
//  Created by Liliana Barnard on 30/4/2023.
//

import SwiftUI

struct PlaceListView: View {
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

//Function Storage
extension PlaceListView {
    
    private func addPlace() {
        withAnimation {
            let newPlace = Place(context: viewContext)
            newPlace.strName = "New Place"
            newPlace.strUrl = ""
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
