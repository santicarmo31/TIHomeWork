//
//  AuthenticationAdapter.swift
//  homework
//
//  Created by Santiago Carmona on 24/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation

final class AuthenticationAdapter: InitInjectable {
    struct Dependencies {
        var authSource: Auth = DemoAuthClient()
        var tokenStore: TokenStore = TokenStoreAdapter.default
    }
    internal var dependencies: Dependencies

    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }
}

extension AuthenticationAdapter {
    func getToken(then completion: @escaping((Result<Token, Error>) -> Void)) {
        if let token = dependencies.tokenStore.currentToken {
            completion(.success(token))
            return
        }
        dependencies.authSource.token { [weak self] (token) in
            guard let token = token else {
                completion(.failure(AuthenticationTokenError.notFound))
                return
            }
            self?.dependencies.tokenStore.currentToken = token
            completion(.success(token))
        }
    }
}

enum AuthenticationTokenError: Error, LocalizedError {
    case notFound

    var errorDescription: String? {
        switch self {
        case .notFound:
            return "Authentication error"
        }
    }
}
