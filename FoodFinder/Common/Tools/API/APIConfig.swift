//
//  APIConfig.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 14/04/2021.
//

import Foundation
import Networking

enum APIConfig {
    static let baseUrl = "https://api.foursquare.com/v2"
}

// MARK: - API endpoints

extension APIConfig {
    static let recommendedVenueEndpoint = "/venues/explore"
    static let detailVenueEndpoint = "/venues"
}

// MARK: - Request options

extension APIConfig {
    static let numberOfResults = "50"
    static let baseRadius = 1000
    static let maxRadius = 100_000

    enum VenueType: String {
        case food
        case drinks
        case shops
    }

    static let apiVersioning = 20_210_331

    static var basicParams: Params {
        var params: Params = [:]
        params["client_id"] = APIConfig.clientID
        params["client_secret"] = APIConfig.clientSecret
        params["v"] = APIConfig.apiVersioning
        return params
    }
}

// MARK: - API Authentification variables

extension APIConfig {
    static var clientID: String {
        // 1
        guard let filePath = Bundle.main.path(forResource: "FoodFinder-Infos", ofType: "plist") else {
            fatalError("Couldn't find file 'FoodFinder-Infos.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "CLIENT_ID") as? String else {
            fatalError("Couldn't find key 'CLIENT_ID' in 'FoodFinder-Infos.plist'.")
        }
        // 3
        if value.starts(with: "_") {
            fatalError("Register for a FourSquare developer account and get an Client id at https://developer.foursquare.com/")
        }
        return value
    }

    static var clientSecret: String {
        // 1
        guard let filePath = Bundle.main.path(forResource: "FoodFinder-Infos", ofType: "plist") else {
            fatalError("Couldn't find file 'FoodFinder-Infos.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "CLIENT_SECRET") as? String else {
            fatalError("Couldn't find key 'CLIENT_CLIENT_SECRET' in 'FoodFinder-Infos.plist'.")
        }
        // 3
        if value.starts(with: "_") {
            fatalError("Register for a FourSquare developer account and get an Client id at https://developer.foursquare.com/")
        }
        return value
    }
}
