//
//  LocationAdapter.swift
//  homework
//
//  Created by Santiago Carmona on 27/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationAdapter: NSObject, InitInjectable {
    struct Dependencies {
        var manager: CLLocationManager = .init()
    }

    static let `default`: LocationAdapter = .init()
    var dependencies: Dependencies
    var updatedLocation: ((CLLocation) -> Void)?
    var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }

    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
        super.init()
        startUpdating()
    }

    private func startUpdating() {
        dependencies.manager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            dependencies.manager.delegate = self
            dependencies.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            dependencies.manager.startUpdatingLocation()
        }
    }
}

extension LocationAdapter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else {
            return
        }
        updatedLocation?(location)
    }
}
