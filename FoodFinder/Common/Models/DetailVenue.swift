//
//  DetailVenue.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 16/04/2021.
//

import Networking

protocol DetailVenueContract {
    var id: String { get }
    var name: String { get }
    var price: Price { get }

    func getBestPhotoUrlString() -> String
}

protocol DetailVenueProviderContract {
    func getDetailVenue() -> DetailVenueContract
}

// MARK: - DetailVenue

struct DetailVenueAPIResponse: Codable, DetailVenueProviderContract {
    let response: DetailVenueResponse

    func getDetailVenue() -> DetailVenueContract {
        response.venue
    }
}

extension DetailVenueAPIResponse: NetworkingJSONDecodable {}

// MARK: - Response

struct DetailVenueResponse: Codable {
    let venue: DetailedVenue
}

extension DetailVenueResponse: NetworkingJSONDecodable {}

// MARK: - Venue

struct DetailedVenue: DetailVenueContract, Codable {
    let id, name: String
    let verified: Bool
    let stats: Stats
    let price: Price
    let createdAt: Int
    let bestPhoto: BestPhoto

    enum CodingKeys: String, CodingKey {
        case id, name
        case verified, stats, price
        case createdAt
        case bestPhoto
    }

    func getBestPhotoUrlString() -> String {
        "\(bestPhoto.prefix)350x350\(bestPhoto.suffix)"
    }
}

extension DetailedVenue: NetworkingJSONDecodable {}

// MARK: - BestPhoto

struct BestPhoto: Codable {
    let id: String
    let createdAt: Int
    let source: Source?
    let prefix: String
    let suffix: String
    let width, height: Int

    enum CodingKeys: String, CodingKey {
        case id, createdAt, source
        case prefix
        case suffix, width, height
    }
}

extension BestPhoto: NetworkingJSONDecodable {}

// MARK: - Source

struct Source: Codable {
    let name: String
    let url: String
}

extension Source: NetworkingJSONDecodable {}

// MARK: - Followers

struct Followers: Codable {
    let count: Int
}

extension Followers: NetworkingJSONDecodable {}

// MARK: - Price

struct Price: Codable {
    let tier: Int
    let message, currency: String
}

extension Price: NetworkingJSONDecodable {}

// MARK: - Stats

struct Stats: Codable {
    let tipCount: Int
}

extension Stats: NetworkingJSONDecodable {}
