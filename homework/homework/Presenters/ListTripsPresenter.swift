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
        unowned var view: ListTripsView
        var authenticationAdapter: AuthenticationAdapter = .init()
        var networkClient: APINetworkClient = NetworkClient()
        var jsonLoader: JsonLoadable = Bundle.main        
    }

    var dependencies: Dependencies
    var trips: [TruckingTrip] = [] {
        didSet {
            dependencies.view.updateTrips(self.trips)
        }
    }

    required init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func listTrips() {
        getTrips { (trips) in
            DispatchQueue.main.async {
                self.trips = trips
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
        dependencies.authenticationAdapter.getToken { (tokenResult) in
            switch tokenResult {
            case .success(let token):
                self.executeTripsRequest(token: token, then: completion)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.dependencies.view.errorGettingTrips(error)
                }
                completion([])
            }
        }
    }

    private func executeTripsRequest(token: Token, then completion: @escaping(([TruckingTrip]) -> Void)) {
        let bodyRequest = dependencies.jsonLoader.loadJson(named: "request_body")
        dependencies.networkClient.executeRequest(
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
                    self.dependencies.view.errorGettingTrips(error)
                }
                completion([])
            }
        }
    }
}
