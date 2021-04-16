//
//  Venue.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 14/04/2021.
//

import Networking

// MARK: - Venue

protocol BasicVenueContract {
    var id: String { get }
    var name: String { get }
    var location: Location { get }
    var categories: [Category] { get }
}

struct BasicVenue: BasicVenueContract, Codable {
    let id, name: String
    let location: Location
    let categories: [Category]
    let venuePage: VenuePage?
}

extension BasicVenue: NetworkingJSONDecodable {}

// MARK: - Category

struct Category: Codable {
    let id, name: String
    let icon: Icon
}

extension Category: NetworkingJSONDecodable {}

// MARK: - Icon

struct Icon: Codable {
    let iconPrefix: String
    let suffix: String

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

extension Icon: NetworkingJSONDecodable {}

// MARK: - Location

struct Location: Codable {
    let address: String?
    let lat, lng: Double
    let distance: Int
    let postalCode: String?
    let cc: String?
    let city: String?
    let state: String?
    let country: String?
    let formattedAddress: [String]
    let crossStreet: String?
}

extension Location: NetworkingJSONDecodable {}

// MARK: - VenuePage

struct VenuePage: Codable {
    let id: String
}

extension VenuePage: NetworkingJSONDecodable {}
