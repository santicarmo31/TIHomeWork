//
//  NetworkError.swift
//  homework
//
//  Created by Santiago Carmona on 26/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case malformedURLRequest
    case invalidStatusCode(String)

    var errorDescription: String? {
        switch self {
        case .malformedURLRequest:
            return "Request is malformed"
        case .invalidStatusCode(let message):
            return message
        }
    }
}
