//
//  HomeMapViewModelTests.swift
//  FoodFinderTests
//
//  Created by Martin Lukacs on 14/04/2021.
//

import XCTest
import Resolver
import Combine

@testable import FoodFinder

class HomeMapViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        Resolver.resetUnitTestRegistrations()
    }
    
    /// Example of how to test published values from viewModel
    /// Check the display alert stream based on denied permission
    /// - Throws: Detect if denied permission is well set. Throw otherwise
    func testLocationPermissionDenied() throws {
        Resolver.resetUnitTestRegistrations()

        Resolver.test.register { LocationsRepositoryDeniedMock() as LocationsRepositoryContract }.scope(.cached)
        let sut = HomeMapViewModel()
        let locationRepository: LocationsRepositoryContract = Resolver.test.resolve()
        locationRepository.checkLocationAuthorization()

        let statePublisher = sut.$displayAlert.collectNext(2)
        
        let displayAlertState = try await(statePublisher)
        XCTAssertEqual(displayAlertState.count, 2)
        XCTAssertFalse(displayAlertState.first!)
        XCTAssertTrue(displayAlertState.last!)
        ResolverScope.cached.reset()
    }
    
    func testUserLocationAutorized() throws {
        Resolver.resetUnitTestRegistrations()

        Resolver.test.register { LocationsRepositoryMock() as LocationsRepositoryContract }.scope(.shared)
        let sut = HomeMapViewModel()
        let locationRepository: LocationsRepositoryContract = Resolver.test.resolve()
        let expectation = self.expectation(description: "waiting for region")

         let subscriber = sut.$currentRegion.sink { value in
             guard value != nil else { return }
             expectation.fulfill()
         }

        locationRepository.checkLocationAuthorization()

        wait(for: [expectation], timeout: 1)
        XCTAssert(sut.currentRegion.center.latitude == TestConfig.testLocation.latitude)
        XCTAssert(sut.currentRegion.center.longitude == TestConfig.testLocation.longitude)
    }
}
