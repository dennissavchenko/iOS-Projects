//
//  Listing.swift
//  Airbnb
//
//  Created by dennis savchenko on 10/08/2024.
//

import Foundation
import MapKit

struct Listing : Identifiable, Hashable {
    
    let id = UUID()
    var images: [String]
    var placeType: PlaceType
    var place: String
    var price: Double
    var rating: Double
    var title: String
    var capacity: Int
    var bedroomsNum: Int
    var bedsNum: Int
    var bathroomNum: Int
    var host: Host
    var features: [Feature]
    var description: String
    var offers: [String]
    var coordinates: [Double]
    
    func getCoordinates() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: coordinates[0], longitude: coordinates[1])
    }
    
}
