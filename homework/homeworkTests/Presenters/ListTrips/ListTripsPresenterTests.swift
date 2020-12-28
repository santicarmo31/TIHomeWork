//
//  ListTripsPresenterTests.swift
//  homeworkTests
//
//  Created by Santiago Carmona on 27/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import XCTest
@testable import homework

class ListTripsPresenterTests: XCTestCase {

    let view = MockListTripsView() // Reference to view must be hold

    func test_listTrips() {
        // Given
        let expect = expectation(description: "List trips")
        var listedTrips: [TruckingTrip] = []
        let presenter = ListTripsPresenter(
            dependencies: ListTripsPresenter.Dependencies(
                view: view,
                authenticationAdapter: AuthenticationAdapter.mock,
                networkClient: MockAPINetwork(using: .graphql),
                jsonLoader: EmptyMockListTripsJsonLoader()
            )
        )
        view.didUpdateTripsGetCalled = {
            listedTrips = $0
            expect.fulfill()
        }
        // When
        presenter.listTrips()
        wait(for: [expect], timeout: 0.1)
        
        // Then
        XCTAssertGreaterThan(listedTrips.count, 0, "Trips must be grather than 0")

    }

    func test_APIError_listingTrips() {
        // Given
        let expect = expectation(description: "List trips error")
        var error: Error?
        let presenter = ListTripsPresenter(
            dependencies: ListTripsPresenter.Dependencies(
                view: view,
                authenticationAdapter: AuthenticationAdapter.mock,
                networkClient: MockAPINetworkError(),
                jsonLoader: EmptyMockListTripsJsonLoader()
            )
        )
        view.didUpdateErrorGettingTripsCalled = { err in
            error = err
            expect.fulfill()
        }
        // When
        presenter.listTrips()
        wait(for: [expect], timeout: 0.1)

        // Then
        XCTAssertNotNil(error, "Error must be returned")
    }

    func test_AuthError_listingTrips() {
        // Given
        let expect = expectation(description: "List trips error")
        var error: Error?
        let presenter = ListTripsPresenter(
            dependencies: ListTripsPresenter.Dependencies(
                view: view,
                authenticationAdapter: AuthenticationAdapter.mockError,
                networkClient: MockAPINetwork(using: .graphql),
                jsonLoader: EmptyMockListTripsJsonLoader()
            )
        )
        view.didUpdateErrorGettingTripsCalled = { err in
            error = err
            expect.fulfill()
        }
        // When
        presenter.listTrips()
        wait(for: [expect], timeout: 0.1)

        // Then
        XCTAssertNotNil(error, "Error must be returned")
    }

    func test_sortTrips_ByID() {
        // Given
        let expect = expectation(description: "Sort trips by id")
        let expectedIdsSortOrder = ["1", "2", "3", "4", "5"]
        var trips: [TruckingTrip] = []
        let presenter = ListTripsPresenter(
            dependencies: ListTripsPresenter.Dependencies(
                view: view,
                authenticationAdapter: AuthenticationAdapter.mock,
                networkClient: MockAPINetwork(using: .graphqlSort),
                jsonLoader: EmptyMockListTripsJsonLoader()
            )
        )
        presenter.trips = MockJson.graphqlSort.load(object: DriverData.self)?.driver.loads.trips ?? []
        view.didUpdateTripsGetCalled = { trips = $0 ; expect.fulfill() }
        // When
        presenter.sortTripsBy(.byId)
        wait(for: [expect], timeout: 0.1)
        // Then
        XCTAssertEqual(expectedIdsSortOrder, trips.compactMap({ $0.id }))
    }

    func test_sortTrips_ByDistance() {
        // Given
        let expect = expectation(description: "Sort trips by distance")
        let expectedDistanceSortOrder: [Double] = [10, 20, 30, 40, 50]
        var trips: [TruckingTrip] = []
        let presenter = ListTripsPresenter(
            dependencies: ListTripsPresenter.Dependencies(
                view: view,
                authenticationAdapter: AuthenticationAdapter.mock,
                networkClient: MockAPINetwork(using: .graphqlSort),
                jsonLoader: EmptyMockListTripsJsonLoader()
            )
        )
        presenter.trips = MockJson.graphqlSort.load(object: DriverData.self)?.driver.loads.trips ?? []
        view.didUpdateTripsGetCalled = { trips = $0 ; expect.fulfill() }
        // When
        presenter.sortTripsBy(.byDistance)
        wait(for: [expect], timeout: 0.1)
        // Then

        XCTAssertEqual(expectedDistanceSortOrder, trips.compactMap({ $0.truckingOrder.tripDistanceMiles }))
    }

}
