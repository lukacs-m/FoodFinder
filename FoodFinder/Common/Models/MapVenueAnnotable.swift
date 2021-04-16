//
//  Restaurant.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 15/04/2021.
//

import CoreLocation
import MapKit

struct MapVenueAnnotable: Identifiable, Hashable {
    let id: String
    let name: String
    let type: String
    let coordinate: CLLocationCoordinate2D

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    // swiftlint:disable operator_whitespace
    static func ==(lhs: MapVenueAnnotable, rhs: MapVenueAnnotable) -> Bool {
        lhs.id == rhs.id
    }
    // swiftlint:enable operator_whitespace
}
