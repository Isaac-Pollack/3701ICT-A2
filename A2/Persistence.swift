//
//  Persistence.swift
//  A2
//
//  Created by Isaac Pollack on 24/4/2023.
//

import Foundation
import CoreData

struct PersistenceHandler {
    static let shared: PersistenceHandler = PersistenceHandler() //Static so that we can always access through context
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let err = error {
                fatalError("Error to load with \(err)")
            }
        }
    }
}
