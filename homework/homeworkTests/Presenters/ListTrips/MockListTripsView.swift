//
//  MockListTripsView.swift
//  homeworkTests
//
//  Created by Santiago Carmona on 27/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
@testable import homework

final class MockListTripsView: ListTripsView {
    var didUpdateTripsGetCalled: (([TruckingTrip]) -> Void)?
    var didUpdateErrorGettingTripsCalled: ((Error) -> Void)?

    func updateTrips(_ trips: [TruckingTrip]) {
        didUpdateTripsGetCalled?(trips)
    }

    func errorGettingTrips(_ error: Error) {
        didUpdateErrorGettingTripsCalled?(error)
    }
}
