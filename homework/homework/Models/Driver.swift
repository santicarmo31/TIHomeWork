//
//  Driver.swift
//  homework
//
//  Created by Santiago Carmona on 23/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation

struct DriverData: Codable {
    let driver: Driver

    private enum RootKey: String, CodingKey {
        case data = "data"
        case driver
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKey.self)
        let subContainer = try container.nestedContainer(keyedBy: RootKey.self, forKey: .data)
        driver = try subContainer.decode(Driver.self, forKey: .driver)
    }
}

struct Driver: Codable {
    let loads: TruckingTripResponse
}

struct TruckingTripResponse: Codable {
    let trips: [TruckingTrip]
}

struct TruckingTrip: Codable, Hashable {
    let id: String
    let deliveryStatus: String
    let progress: String
    let deliveredAt: Date
    let scheduledDeliveryOn: Date
    let truckingOrder: TruckingOrder

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: TruckingTrip, rhs: TruckingTrip) -> Bool {
        return lhs.id == rhs.id
    }
}

struct TruckingOrder: Codable {
    let id: String
    let tripDistanceMiles: Double
    let orderType: String
    let locationFrom: TruckingLocation
    let locationTo: TruckingLocation
}

struct TruckingLocation: Codable {
    let id: String
    let phone: String
    let address: Address
    let name: String
    let coordinates: GeoPoint
}

struct Address: Codable {
    let street: String
    let street2: String?
    let city: String
    let postalCode: String
    let state: String
    let country: String
}

struct GeoPoint: Codable {
    let latitude: Double
    let longitude: Double
}
