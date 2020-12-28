//
//  Constants.swift
//  homework
//
//  Created by Alex Rouse on 4/7/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation

struct Constants {

    static var apiURL = URL(string: "https://api.indigoag.build/graphql/")!
    static let authorizationHeader = "Authorization"
    static let tripIDFormat = "Trip ID %@"
    static let tripDistanceFormat = "Distance %.1f"
    static let startLocationTitle = "Start Location"
    static let endLocationTitle = "End Location"
    static let sortTripsTitle = "Sort Trips"
    static let sortTripsMessage = "please select an option"
    static let sortByIDTitle = "By ID"
    static let sortByDistanceTitle = "By Distance"
    static let sortByRandomTitle = "By Random"
}
