//
//  ViewModel.swift
//  A2
//
//  Created by Isaac Pollack on 24/4/2023.
//

import Foundation 
import CoreData
import SwiftUI

fileprivate var defaultImage = Image(systemName: "photo").resizable()
fileprivate var downloadImages: [URL:Image] = [:]

extension Place {
    //The Places name
    var strName:String {
        get { self.name ?? "unknown" }
        set { self.name = newValue }
    }
    
    //The Places ImageURL
    var strUrl: String {
        get { self.imageURL?.absoluteString ?? "" }
        set {
            guard let url = URL(string: newValue) else {return}
            self.imageURL = url
        }
    }
    
    //The Places latitude
    var strLatitude: String {
        get { String(format: "%.4f", self.latitude) }
        set {
            guard let lat: Double = Double(newValue), lat <= 90, lat >= -90 else {return}
            latitude = lat
        }
    }
    
    //The Places longitude
    var strLongitude: String {
        get { String(format: "%.4f", self.longitude) }
        set {
            guard let long: Double = Double(newValue), long <= 180, long >= -180 else {return}
            longitude = long
        }
    }
    
    //Fetch image
    func getImage() async ->Image {
        guard let url = self.imageURL else { return defaultImage }
        if let image = downloadImages[url] { return image }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let uiimg = UIImage(data: data) else { return defaultImage }
            let image = Image(uiImage: uiimg).resizable()
            downloadImages[url]=image
            return image
        }catch {
            print("Error downloading \(url): \(error.localizedDescription)")
        }
        return defaultImage
    }
    
    //Save
    @discardableResult
        func save() -> Bool {
            do {
                try managedObjectContext?.save()
            } catch {
                print("Error saving \(error)")
                return false
            }
            return true
        }
}
