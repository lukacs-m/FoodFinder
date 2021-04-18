//
//  LocationRepository.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 12/04/2021.
//

import Combine
import CoreLocation
import Foundation

protocol LocationsRepositoryContract {
    var currentLocation: CurrentValueSubject<CLLocationCoordinate2D?, Never> { get }
    var permissionDenied: CurrentValueSubject<Bool, Never> { get }

    func checkLocationAuthorization()
}

final class LocationsRepository: NSObject, LocationsRepositoryContract {
    var currentLocation: CurrentValueSubject<CLLocationCoordinate2D?, Never> = .init(nil)
    var permissionDenied: CurrentValueSubject<Bool, Never> = .init(false)

    private var locationManager: CLLocationManager?

    override init() {
        super.init()
        locationManager = CLLocationManager()

        setUp()
    }

    func checkLocationAuthorization() {
        guard let status = locationManager?.authorizationStatus else {
            return
        }
        followAuthorization(for: status)
    }
}

extension LocationsRepository: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation.send(location.coordinate)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        followAuthorization(for: status)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - Setup & Utils

extension LocationsRepository {
    private func setUp() {
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }

    private func followAuthorization(for status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            permissionDenied.send(false)
            locationManager?.requestLocation()
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            permissionDenied.send(true)
        @unknown default:
            break
        }
    }
}
