//
//  MockAuthentication.swift
//  homework
//
//  Created by Santiago Carmona on 27/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation

struct MockAuthentication: Authenticable {
    func getToken(then completion: @escaping ((Result<Token, Error>) -> Void)) {
        completion(.success("testToken"))
    }
}
