//
//  ViewModel.swift
//  A2
//
//  Created by Isaac Pollack on 24/4/2023.
//

import Foundation
import CoreData
import SwiftUI

let defaultImage = Image(systemName: "photo").resizable()
var downloadImages :[URL:Image] = [:]
extension Animal {
    var strName:String {
        get {
            self.name ?? "unknown"
        }
        set {
            self.name = newValue
        }
    }
    var strAge : String {
        get {
            "\(self.age)"
        }
        set {
            guard let age = Int16(newValue) else {
                return
            }
            self.age = age
        }
    }
    var strUrl: String {
        get{
            self.imgurl?.absoluteString ?? ""
        }
        set {
            guard let url = URL(string: newValue) else {return}
            self.imgurl = url
        }
    }
    var rowDisplay:String {
        "Name: \(self.strName) (age: \(self.strAge))"
    }
    func getImage() async ->Image {
        guard let url = self.imgurl else {return defaultImage}
        if let image = downloadImages[url] {return image}
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let uiimg = UIImage(data: data) else {return defaultImage}
            let image = Image(uiImage: uiimg).resizable()
            downloadImages[url]=image
            return image
        }catch {
            print("error in download image \(error)")
        }
        
        return defaultImage
    }
}
func createInitAnimals() {
    
}
func saveData() {
    let ctx = PersistenceHandler.shared.container.viewContext
    do {
        try ctx.save()
    }catch {
        print("Error to save with \(error)")
    }
}

