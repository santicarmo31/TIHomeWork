//
//  MockAuthentication.swift
//  homework
//
//  Created by Santiago Carmona on 27/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

@testable import homework
import Foundation

struct MockAuth: Auth {
    func token(then completion: @escaping (String?) -> Void) {
        completion("TestToken")
    }
}

struct MockAuthError: Auth {
    func token(then completion: @escaping (String?) -> Void) {
        completion(nil)
    }
}

struct MockTokenStore: TokenStore {
    var currentToken: Token?
}

extension AuthenticationAdapter {
    static let mock: AuthenticationAdapter = {
        return AuthenticationAdapter(
            dependencies: Dependencies(
                authSource: MockAuth(),
                tokenStore: MockTokenStore()
            )
        )
    }()

    static let mockError: AuthenticationAdapter = {
        return AuthenticationAdapter(
            dependencies: Dependencies(
                authSource: MockAuthError(),
                tokenStore: MockTokenStore()
            )
        )
    }()
}
