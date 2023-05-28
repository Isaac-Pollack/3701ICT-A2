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

/// The PersistenceHandler struct is responsible for managing the Core Data stack and providing access to the NSPersistentContainer.
/// The shared property is a static property of PersistenceHandler that allows accessing the shared instance of PersistenceHandler throughout the app.
/// The container property is an instance of NSPersistentContainer, which represents the Core Data stack.
/// In the init() method, the container is initialized with the name "Model", which refers to the Core Data model file in your project.
/// The container.loadPersistentStores method is called to load the persistent stores defined in the model.
/// The closure passed to loadPersistentStores handles any error that occurs during the loading process. If an error occurs, a fatalError is triggered with a descriptive error message.

// /Overall, this code sets up a PersistenceHandler struct that initializes the Core Data stack by loading the persistent stores defined in the model. The shared property provides access to the shared instance of PersistenceHandler throughout the app, allowing you to access the Core Data stack and perform database operations.
