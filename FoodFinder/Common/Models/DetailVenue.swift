//
//  DetailVenue.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 16/04/2021.
//

import Networking

protocol DetailVenueContract {}

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

struct DetailedVenue: Codable, DetailVenueContract {
    let id, name: String
    let verified: Bool
    let stats: Stats
    let price: Price
    let photos: Photos
    let createdAt: Int
    let bestPhoto: BestPhoto

    enum CodingKeys: String, CodingKey {
        case id, name
        case verified, stats, price
        case photos, createdAt
        case bestPhoto
    }
}

extension DetailedVenue: NetworkingJSONDecodable {}

// MARK: - BestPhoto

struct BestPhoto: Codable {
    let id: String
    let createdAt: Int
    let source: Source?
    let bestPhotoPrefix: String
    let suffix: String
    let width, height: Int

    enum CodingKeys: String, CodingKey {
        case id, createdAt, source
        case bestPhotoPrefix = "prefix"
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

// MARK: - Photos

struct Photos: Codable {
    let count: Int
    let groups: [PhotosGroup]
}

extension Photos: NetworkingJSONDecodable {}

// MARK: - PhotosGroup

struct PhotosGroup: Codable {
    let type, name: String
    let count: Int
    let items: [BestPhoto]
}

extension PhotosGroup: NetworkingJSONDecodable {}

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
