//
//  MKCoordinateRegion+Extensions.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 15/04/2021.
//

import MapKit

extension MKCoordinateRegion {
    func distanceMax() -> CLLocationDistance {
        let furthest = CLLocation(latitude: center.latitude + (span.latitudeDelta / 2),
                                  longitude: center.longitude + (span.longitudeDelta / 2))
        let centerLoc = CLLocation(latitude: center.latitude, longitude: center.longitude)
        return centerLoc.distance(from: furthest)
    }
}
