//
//  A2App.swift
//  A2
//
//  Created by Isaac Pollack on 24/3/2023.
//

import SwiftUI

@main
struct A2App: App {
    var model = PersistenceHandler.shared //To allow access to the context
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, model.container.viewContext)
        }
    }
}
