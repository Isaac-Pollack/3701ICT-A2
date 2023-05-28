import XCTest
import CoreData
@testable import A2

class A2Tests: XCTestCase {

    var persistenceHandler: PersistenceHandler!
    var viewContext: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        persistenceHandler = PersistenceHandler.shared
        viewContext = persistenceHandler.container.viewContext
    }

    override func tearDown() {
        super.tearDown()
        // Clean up any created test data
        deleteAllPlaces()
    }

    func testAddPlace() {
        let placeName = "Test Place"
        let placeLatitude = "37.7749"
        let placeLongitude = "-122.4194"
        
        // Create a new place
        let newPlace = Place(context: viewContext)
        newPlace.strName = placeName
        newPlace.strLatitude = placeLatitude
        newPlace.strLongitude = placeLongitude
        
        // Save the context
        XCTAssertTrue(saveContext(), "Failed to save the context")
        
        // Fetch all places
        let places = fetchAllPlaces()
        
        // Verify that the new place is added
        XCTAssertEqual(places.count, 1, "Unexpected number of places")
        XCTAssertEqual(places.first?.strName, placeName, "Unexpected place name")
        XCTAssertEqual(places.first?.strLatitude, placeLatitude, "Unexpected place latitude")
        XCTAssertEqual(places.first?.strLongitude, placeLongitude, "Unexpected place longitude")
    }
    
    func testDeletePlace() {
        // Create a test place
        let place = Place(context: viewContext)
        place.strName = "Test Place"
        place.strLatitude = "37.7749"
        place.strLongitude = "-122.4194"
        XCTAssertTrue(saveContext(), "Failed to save the context")
        
        // Fetch all places
        var places = fetchAllPlaces()
        XCTAssertEqual(places.count, 1, "Unexpected number of places before deletion")
        
        // Delete the test place
        viewContext.delete(place)
        XCTAssertTrue(saveContext(), "Failed to save the context")
        
        // Fetch all places after deletion
        places = fetchAllPlaces()
        XCTAssertEqual(places.count, 0, "Unexpected number of places after deletion")
    }
    
    func testPlaceListView() {
        let place1 = Place(context: viewContext)
        place1.strName = "Place 1"
        place1.strLatitude = "37.7749"
        place1.strLongitude = "-122.4194"
        
        let place2 = Place(context: viewContext)
        place2.strName = "Place 2"
        place2.strLatitude = "34.0522"
        place2.strLongitude = "-118.2437"
        
        XCTAssertTrue(saveContext(), "Failed to save the context")
    }
    
    // Helper methods
    
    func deleteAllPlaces() {
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        if let places = try? viewContext.fetch(fetchRequest) {
            places.forEach { place in
                viewContext.delete(place)
            }
            _ = saveContext()
        }
    }
    
    func fetchAllPlaces() -> [Place] {
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        if let places = try? viewContext.fetch(fetchRequest) {
            return places
        }
        return []
    }
    
    @discardableResult
    func saveContext() -> Bool {
        do {
            try viewContext.save()
            return true
        } catch {
            return false
        }
    }

}
