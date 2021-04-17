//
//  VenueRepositoryTests.swift
//  FoodFinderTests
//
//  Created by Martin Lukacs on 16/04/2021.
//

import XCTest
import Resolver
import Combine
import Foundation
import Networking

@testable import FoodFinder

class VenueRepositoryTests: XCTestCase {
    
    override func setUpWithError() throws {
        Resolver.resetUnitTestRegistrations()
    }
    
    ///  Example of how to test functions from repository
    ///  We are testing one of the calls used by viewmodels to get details venue data
    /// - Throws: Error if not the dummy test data that is checked
    func testGetDetailedVenue() throws {
        
        Resolver.test.register { VenueAPIDetailVenuMock() as VenueAPIContract }.scope(.shared)
        
        let sut = VenueRepository()
        let publisher = sut.getDetails(ofType: DetailedVenue.self,
                                       for: ModelsMockFactory.getMapVenuAnnotionDummy())
        
        let publisherStreamResponse = try await(publisher)
        XCTAssertNotNil(publisherStreamResponse)
        XCTAssert(publisherStreamResponse?.id == ModelsMockFactory.getDetailedVenueDummy().id)
        XCTAssert(publisherStreamResponse?.name == ModelsMockFactory.getDetailedVenueDummy().name)
    }
}
