//
//  A2App.swift
//  A2
//
//  Created by Isaac Pollack on 24/3/2023.
//

import SwiftUI

@main
struct A2App: App {
    let persistenceHandler = PersistenceHandler.shared
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceHandler.container.viewContext)
        }
    }
}
