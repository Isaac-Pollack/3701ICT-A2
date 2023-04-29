//
//  ContentView.swift
//  A2
//
//  Created by Isaac Pollack on 20/3/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var ctx
    @FetchRequest(sortDescriptors: []) var animals : FetchedResults<Animal>

    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(animals) {
                        animal in
                        NavigationLink(destination: DetailView(animal: animal)) {
                            RowView(animal: animal)
                        }
                    }
                }
                Button("+"){
                    addAnimal()
                }

            }.navigationTitle("My animal friends")
                .onAppear{
                    print("Number of animals:\(animals.count)")
                }
        }
    }
    func addAnimal() {
        let animal = Animal(context: ctx)
        animal.name = "New Animal"
        animal.age = 1
        saveData()
    }
}
