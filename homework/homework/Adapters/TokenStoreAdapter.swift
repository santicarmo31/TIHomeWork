//
//  TokenStore.swift
//  homework
//
//  Created by Santiago Carmona on 26/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
protocol TokenStore {
    var currentToken: Token? { get set }
}

final class TokenStoreAdapter: TokenStore {
    static let `default`: TokenStoreAdapter = .init()
    var currentToken: Token?
}
