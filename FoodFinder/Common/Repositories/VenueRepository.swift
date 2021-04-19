//
//  VenueRepository.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 14/04/2021.
//

import Combine
import CoreLocation
import Networking
import Resolver
import SwiftUICombineToolBox

/// Protocol containing default declarationn for venu data fetchinng
protocol VenueRepositoryContract {
    func getRecommended<ReturnType: BasicVenueContract>(ofType: ReturnType.Type,
                                                        for location: CLLocationCoordinate2D,
                                                        with radius: Int) -> AnyPublisher<[ReturnType], Never>

    func getDetails<ReturnType: DetailVenueContract>(ofType type: ReturnType.Type,
                                                     with detailVenueId: String) -> AnyPublisher<ReturnType?, Never>
}

final class VenueRepository: VenueRepositoryContract {
    @Injected private var api: VenueAPIContract
    @Injected var cache: Cache<String, DetailVenueContract>
    private var cancelBag = CancelBag()

    init() {}

    /*
        /// Fetch the data of recommanded venue
        /// - Parameters:
        ///   - ofType: Type of data to be returned
        ///   - location: current user locationn
        ///   - radius: radius of search
        /// - Returns: returns an array of recommanded venues
     */
    func getRecommended<ReturnType: BasicVenueContract>(ofType: ReturnType.Type,
                                                        for location: CLLocationCoordinate2D,
                                                        with radius: Int) -> AnyPublisher<[ReturnType], Never> {
        let correctRadius = radius < APIConfig.maxRadius ? radius : APIConfig.maxRadius

        let params = buildParams(for: location, type: .food, and: correctRadius)
        let path = APIConfig.recommendedVenueEndpoint

        return api.getData(ofKind: RecommandedVenueAPIResponse.self, from: path, with: params)
            .map { [weak self] results -> [ReturnType] in
                guard let self = self,
                      let venues = self.parseVenues(from: results) as? [ReturnType] else {
                    return [ReturnType]()
                }
                return venues
            }.replaceError(with: [ReturnType]())
            .eraseToAnyPublisher()
    }

    func getDetails<ReturnType: DetailVenueContract>(ofType type: ReturnType.Type,
                                                     with detailVenueId: String) -> AnyPublisher<ReturnType?, Never> {
        if let detailVenue = cache[detailVenueId] as? ReturnType {
            return Just(detailVenue).eraseToAnyPublisher()
        }
        let params = APIConfig.basicParams
        let path = "\(APIConfig.detailVenueEndpoint)/\(detailVenueId)"

        return api.getData(ofKind: DetailVenueAPIResponse.self, from: path, with: params)
            .map { [weak self] results -> ReturnType? in
                guard let self = self,
                      let detailVenue = self.parseDetail(from: results) as? ReturnType else {
                    return nil
                }
                self.cache[detailVenueId] = detailVenue
                return detailVenue
            }.replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}

extension VenueRepository {
    private func buildParams(for location: CLLocationCoordinate2D,
                             type: APIConfig.VenueType = .food,
                             and radius: Int = APIConfig.baseRadius) -> Params {
        var params = APIConfig.basicParams
        params["section"] = type.rawValue
        params["ll"] = "\(location.latitude),\(location.longitude)"
        params["radius"] = radius
        return params
    }

    private func parseVenues(from recommandedResponse: BasicVenueProdiderContract) -> [BasicVenueContract] {
        recommandedResponse.getBasicVenues()
    }

    private func parseDetail(from detailVenueResponse: DetailVenueProviderContract) -> DetailVenueContract {
        detailVenueResponse.getDetailVenue()
    }
}
