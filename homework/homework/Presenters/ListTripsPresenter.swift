//
//  ListTripsPresenter.swift
//  homework
//
//  Created by Santiago Carmona on 27/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation

protocol ListTripsView: class {
    func updateTrips(_ trips: [TruckingTrip])
    func endRefreshing()
    func errorGettingTrips(_ error: Error)
}

enum SortTrip: CaseIterable {
    case byId, byDistance, random

    var title: String {
        switch self {
        case .byId:
            return "By ID"
        case .byDistance:
            return "By Distance"
        case .random:
            return "Random"
        }
    }
}

class ListTripsPresenter: InitInjectable {
    struct Dependencies {
        var view: ListTripsView
        var authenticationAdapter: Authenticable = MockAuthentication()
        var networkClient: APINetworkClient = MockTripListNetwork()
        var jsonLoader: JsonLoadable = Bundle.main
    }

    var dependencies: Dependencies
    private var trips: [TruckingTrip] = [] {
        didSet {
            self.view.updateTrips(self.trips)
        }
    }

    required init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func listTrips() {
        getTrips { [weak self] (trips) in
            DispatchQueue.main.async {
                self?.trips = trips
            }
        }
    }

    func refreshTrips() {
        getTrips { [weak self] (trips) in
            DispatchQueue.main.async {
                self?.trips = trips
                self?.view.endRefreshing()
            }
        }
    }

    func sortTripsBy(_ sort: SortTrip) {
        switch sort {
        case .byId:
            trips = trips.sorted(by: { $0.id < $1.id })
        case .byDistance:
            trips = trips.sorted(by: {
                $0.truckingOrder.tripDistanceMiles < $1.truckingOrder.tripDistanceMiles
            })
        case .random:
            trips = trips.shuffled()
        }
    }

    private func getTrips(then completion: @escaping(([TruckingTrip]) -> Void)) {
        self.authenticationAdapter.getToken { [weak self] (tokenResult) in
            switch tokenResult {
            case .success(let token):
                self?.executeTripsRequest(token: token, then: completion)
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view.errorGettingTrips(error)
                }
                completion([])
            }
        }
    }

    private func executeTripsRequest(token: Token, then completion: @escaping(([TruckingTrip]) -> Void)) {
        let bodyRequest = self.jsonLoader.loadJson(named: "request_body")
        self.networkClient.executeRequest(
            Endpoint<DriverData>(
                Constants.apiURL.absoluteString,
                params: bodyRequest,
                method: .post,
                headers: [Constants.authorizationHeader: token.bearerFormat]
            )
        ) { result in
            switch result {
            case .success(let data):
                completion(data.driver.loads.trips)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view.errorGettingTrips(error)
                }
                completion([])
            }
        }
    }
}
