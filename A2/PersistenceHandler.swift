//
//  PersistenceHandler.swift
//  A2
//
//  Created by Isaac Pollack on 24/4/2023.
//

import Foundation
import CoreData

struct PH {
    static let shared = PH()
    let container : NSPersistentContainer //Static so that we can always access through context
    init() {
        container = NSPersistentContainer(name: "A2DataModel")
        container.loadPersistentStores {_, error in
            if let e = error {
                fatalError("Loading Error with \(e)")
            }
        }
    }
}

func saveData() {
    let context = PH.shared.container.viewContext
    do {
        try context.save()
    } catch {
        fatalError("Save Error with \(error)")
    }
}
