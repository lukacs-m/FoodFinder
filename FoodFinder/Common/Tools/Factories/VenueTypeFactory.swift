//
//  VenueTypeFactory.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 15/04/2021.
//

import CoreLocation

struct VenueFactory {
    static func createMapVenueAnnotable(from venue: BasicVenueContract) -> MapVenueAnnotable {
        let type = venue.categories.first?.name ?? ""
        let coorDinate = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)

        return MapVenueAnnotable(id: venue.id, name: venue.name, type: type, coordinate: coorDinate)
    }
}
