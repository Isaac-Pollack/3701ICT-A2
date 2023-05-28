//
//  ViewModel.swift
//  A2
//
//  Created by Isaac Pollack on 24/4/2023.
//

import Foundation
import CoreData
import SwiftUI
import MapKit

fileprivate var defaultImage = Image(systemName: "photo").resizable()
fileprivate var downloadImages: [URL:Image] = [:]

extension Place {
    /// This is what our app is built around; the Place entity in our core data model.
    /// -
    /// We extend this to make our retrieval and setting functionality much easier, as well as employing it as an ObservableObject by nature.

    var strName: String {
        /// Get the Place's name, if nothing exists set it to the built in newValue. This value IS optional.
        get { self.name ?? "unknown" }
        set { self.name = newValue }
    }

    var strDetails: String {
        /// Get the Place's details, if nothing exists set it to the built in newValue. This value IS optional.
        get { self.details ?? "unknown" }
        set { self.details = newValue }
    }

    var strUrl: String {
        /// Get the Place's image link and save it as imageURL, if nothing exists set it to the built in newValue. This value IS optional.
        get { self.imageURL?.absoluteString ?? "" }
        set {
            guard let url = URL(string: newValue) else {return}
            self.imageURL = url
        }
    }

    var strLatitude: String {
        /// Get the Place's latitude, if nothing exists set it to the built in newValue. This value IS optional.
        get { String(format: "%.4f", self.latitude) }
        set {
            guard let lat: Double = Double(newValue), lat <= 90, lat >= -90 else {return}
            latitude = lat
        }
    }

    var strLongitude: String {
        /// Get the Place's longitude and convert it to the correct data type, if nothing exists set it to the built in newValue. This value IS optional.
        get { String(format: "%.4f", self.longitude) }
        set {
            guard let long: Double = Double(newValue), long <= 180, long >= -180 else {return}
            longitude = long
        }
    }

    func getImage() async ->Image {
        /// Asynchronously fetch the image based on the imageURL we set within the var strUrl declaration.
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

    @discardableResult
    func save() -> Bool {
        /// This function attempts to save the results of the edited object.
        do {
            try managedObjectContext?.save()
        } catch {
            print("Error saving \(error)")
            return false
        }
        return true
    }
}

class MyLocation: ObservableObject, Identifiable {
    @Published var name : String
    @Published var latitude :Double
    @Published var longitude : Double
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
    }
}

/// strName: Retrieves and sets the name of the place, using a default value if it's not set.
/// strDetails: Retrieves and sets the details of the place, using a default value if it's not set.
/// strUrl: Retrieves and sets the image URL of the place, using an empty string if it's not set. It also converts the URL string to a valid URL object when setting the value.
/// strLatitude: Retrieves and sets the latitude of the place, formatting it to a string with four decimal places. It performs validation when setting the value to ensure it falls within the valid latitude range.
/// strLongitude: Retrieves and sets the longitude of the place, formatting it to a string with four decimal places. It performs validation when setting the value to ensure it falls within the valid longitude range.
/// updateRegion: Updates the provided MKCoordinateRegion object with the coordinates of the place.
/// getImage: Asynchronously fetches the image associated with the place based on the stored imageURL. It uses a dictionary (downloadImages) to cache downloaded images and returns a default image if the download fails.
/// save: Attempts to save the edited object to Core Data, returning a boolean indicating the success of the save operation.

/// These extensions provide convenient functionality for retrieving and setting properties of the Place entity, as well as handling image fetching and saving operations.
