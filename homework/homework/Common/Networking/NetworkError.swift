//
//  NetworkError.swift
//  homework
//
//  Created by Santiago Carmona on 26/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case malformedURLRequest
    case invalidStatusCode(String)
}
