//
//  ChecklistDataModel.swift
//  A2
//
//  Created by Isaac Pollack on 30/3/2023.
//

import Foundation
///Checklist is built around JSON for data persistance purposes.
/// -
///It is both Hashable and Codable in nature.
struct Checklist: Hashable, Codable {
    ///Fully editable, reflecting in parent/sub menus in real-time, including sub-items.
    var name: String // Checklist Name.
    var items: [[String]] // Array of sub-items.
}

struct ChecklistDataModel: Codable {
    ///This is the main array of checklists for the app.
    var checklists:[Checklist]

    init() {
        ///Initialise ``ChecklistDataModel`` and load data using ``loadChecklists()``
        checklists = []
        loadChecklists()
    }

    mutating func loadChecklists() {
        ///This function will attempt to get the file path, read the data and try to decode it, setting our ``defaultChecklists`` as the files content if unsuccessful.
        guard let path = getFile(),
            let data = try? Data(contentsOf: path),
            let datamodel = try? JSONDecoder().decode(ChecklistDataModel.self, from: data)
        else {
            self.checklists = defaultChecklists // Set default to defaultChecklists
            return
        }
        checklists = datamodel.checklists // Load checklists after decoded
    }

    func saveChecklists() {
        ///This function is how we will store the data, in ``checklist.json``
        guard let path = getFile(),
            let data = try? JSONEncoder().encode(self)
        else {
            return
        }
        try? data.write(to: path)
    }
}

func getFile() -> URL? {
    ///This function is how we will retrieve the data store, found  in ``func saveChecklist()``, else return nil.
    let fileName = "checklist.json" // Our local data store used in all related functions.
    let fm = FileManager.default
    guard let path = fm.urls(for: .documentDirectory, in:
                                FileManager.SearchPathDomainMask.userDomainMask).first
    else {
        return nil
    }
    return path.appendingPathComponent(fileName)
}

var defaultChecklists: [Checklist] = [
    ///If the ``loadChecklist()`` function  fails to retrieve the JSON data saved locally for whatever reason, this will populate it instead.
    Checklist(name: "Groceries", items: [["Bread", "square"], ["Milk", "checkmark.square.fill"], ["Apples", "checkmark.square.fill"], ["Oranges", "square"]]),
    Checklist(name: "Chores", items: [["Clean Kitchen", "checkmark.square.fill"], ["Take rubbish out", "square"], ["Do homework", "square"]])
]
