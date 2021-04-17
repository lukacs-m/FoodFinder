//
//  VenueAPI.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 14/04/2021.
//

import Combine
import Networking

protocol VenueAPIContract {
    func getData<ReturnType: NetworkingJSONDecodable>(ofKind: ReturnType.Type,
                                                      from path: String,
                                                      with params: Params) -> AnyPublisher<ReturnType, Error>
}

extension API: VenueAPIContract {
    func getData<ReturnType: NetworkingJSONDecodable>(ofKind: ReturnType.Type,
                                                      from path: String,
                                                      with params: Params) -> AnyPublisher<ReturnType, Error> {
        get(path, params: params)
    }
}
