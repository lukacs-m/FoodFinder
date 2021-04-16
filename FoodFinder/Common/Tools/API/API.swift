//
//  API.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 14/04/2021.
//

import Networking

final class API: NetworkingService {
    var network = NetworkingClient(baseURL: APIConfig.baseUrl)

    init() {
        setUp()
    }
}

extension API {
    private func setUp() {
        #if DEBUG
        network.logLevels = .debug
        #else
        network.logLevels = .off
        #endif
    }
}
