//
//  FoursquareAPIResponse.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 14/04/2021.
//

import Networking

protocol BasicVenueProdiderContract {
    func getBasicVenues() -> [BasicVenueContract]
}

// MARK: - RecommandedVenueAPIResponse

struct RecommandedVenueAPIResponse: Codable, BasicVenueProdiderContract {
    let response: Response

    func getBasicVenues() -> [BasicVenueContract] {
        let items = response.groups.flatMap(\.items)
        let venues = items.map(\.venue)
        return venues
    }
}

extension RecommandedVenueAPIResponse: NetworkingJSONDecodable {}

// MARK: - Response

struct Response: Codable {
    let totalResults: Int
    let groups: [VenueGroups]
}

extension Response: NetworkingJSONDecodable {}

// MARK: - Group

struct VenueGroups: Codable {
    let name: String
    let items: [GroupItem]
}

extension VenueGroups: NetworkingJSONDecodable {}

// MARK: - GroupItem

struct GroupItem: Codable {
    let venue: BasicVenue
}

extension GroupItem: NetworkingJSONDecodable {}
