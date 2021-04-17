//
//  VenueAPIContractMock.swift
//  FoodFinderTests
//
//  Created by Martin Lukacs on 16/04/2021.
//

import Combine
import Networking
import SwiftUICombineToolBox
@testable import FoodFinder

// swiftlint:disable force_cast
final class VenueAPIDetailVenuMock: VenueAPIContract {
    func getData<ReturnType: NetworkingJSONDecodable>(ofKind: ReturnType.Type,
                                                      from path: String,
                                                      with params: Params) -> AnyPublisher<ReturnType, Error> {
        
        Just(ModelsMockFactory.getDetailVenueAPIResponseDummy() as! ReturnType).switchToAnyPublisher(with: Error.self)
    }
}
// swiftlint:enable force_cast
