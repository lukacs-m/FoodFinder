//
//  LocationRepositoryMock.swift
//  FoodFinderTests
//
//  Created by Martin Lukacs on 14/04/2021.
//

import Combine
import CoreLocation
@testable import FoodFinder

enum TestConfig {
    static let testLocation = CLLocationCoordinate2D(latitude: 48.8534, longitude: 2.3488)
}

final class LocationsRepositoryDeniedMock: LocationsRepositoryContract {
    var currentLocation: CurrentValueSubject<CLLocationCoordinate2D?, Never> = .init(nil)
    
    var permissionDenied: CurrentValueSubject<Bool, Never> = .init(false)
    
    func checkLocationAuthorization() {
        permissionDenied.send(true)
    }
}

final class LocationsRepositoryMock: LocationsRepositoryContract {
    var currentLocation: CurrentValueSubject<CLLocationCoordinate2D?, Never> = .init(nil)
    
    var permissionDenied: CurrentValueSubject<Bool, Never> = .init(false)
    
    func checkLocationAuthorization() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.currentLocation
                .send(TestConfig.testLocation)
        }
    }
}
