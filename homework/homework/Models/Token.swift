//
//  Token.swift
//  homework
//
//  Created by Santiago Carmona on 26/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation

typealias Token = String
extension Token {
    var bearerFormat: String {
        return "Bearer \(self)"
    }
}
