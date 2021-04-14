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

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewModelInitialState() throws {
        let sut = HomeMapViewModel()
        XCTAssert(sut.state == .loading)
    }
    
    func testLocationPermissionDenied() throws {
        Resolver.test.register { LocationsRepositoryDeniedMock() as LocationsRepositoryContract }.scope(.shared)
        let sut = HomeMapViewModel()
        let locationRepository: LocationsRepositoryContract = Resolver.test.resolve()
        locationRepository.checkLocationAuthorization()

        let statePublisher = sut.$displayAlert.collectNext(2)
        
        let displayAlertState = try await(statePublisher)
        XCTAssertEqual(displayAlertState.count, 2)
        XCTAssertFalse(displayAlertState.first!)
        XCTAssertTrue(displayAlertState.last!)
    }
    
    func testUserLocationAutorized() throws {
        Resolver.test.register { LocationsRepositoryMock() as LocationsRepositoryContract }.scope(.shared)
        let sut = HomeMapViewModel()
        let locationRepository: LocationsRepositoryContract = Resolver.test.resolve()
        locationRepository.checkLocationAuthorization()

        let statePublisher = sut.$currentRegion.collectNext(1)
        
        let displayAlertState = try await(statePublisher)
        XCTAssertEqual(displayAlertState.count, 1)
        XCTAssert(displayAlertState.last!?.center.latitude == TestConfig.testLocation.latitude)
        XCTAssert(displayAlertState.last!?.center.longitude == TestConfig.testLocation.longitude)
    }
}
