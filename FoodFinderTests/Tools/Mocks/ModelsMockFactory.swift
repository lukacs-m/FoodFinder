//
//  ModelsMockFactory.swift
//  FoodFinderTests
//
//  Created by Martin Lukacs on 16/04/2021.
//

import Networking
import CoreLocation
@testable import FoodFinder

class DummyDetail: DetailVenueContract {
    let id: String
    
    init(){
        id = "1"
    }
}

struct ModelsMockFactory {
    static func getDetailVenueAPIResponseDummy() -> DetailVenueAPIResponse {
        let reponse = DetailVenueResponse(venue: ModelsMockFactory.getDetailedVenueDummy())
        return DetailVenueAPIResponse(response: reponse)
    }
    
    static func getDetailedVenueDummy() -> DetailedVenue {
        let stat = Stats(tipCount: 1)
        let price = Price(tier: 2, message: "expensive", currency: "Euro")
        let bestPhoto = BestPhoto(id: "3",
                                  createdAt: 1,
                                  source: nil,
                                  bestPhotoPrefix: "photoPrefix",
                                  suffix: "photoSuffix",
                                  width: 100,
                                  height: 100)
        return DetailedVenue(id: "1",
                             name: "testDetailView",
                             verified: true,
                             stats: stat,
                             price: price,
                             createdAt: 12,
                             bestPhoto: bestPhoto)
    }
    
    static func getMapVenuAnnotionDummy() -> MapVenueAnnotion {
        MapVenueAnnotion(id: "1", name: "testAnnotation", type: "food", coordinate: CLLocationCoordinate2D(latitude: 48.2, longitude: 2.2))
    }
}
