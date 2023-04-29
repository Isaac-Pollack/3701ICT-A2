//
//  A2App.swift
//  A2
//
//  Created by Isaac Pollack on 24/3/2023.
//

import SwiftUI

@main
struct A2App: App {
    var ph = PH.shared //To allow access to the context
    @State var model = ChecklistDataModel()
    var body: some Scene {
        WindowGroup {
            ContentView(model: $model).environment(\.managedObjectContext, ph.container.viewContext) //remove model: $model when transferring fully to coreData
        }
    }
}
