//
//  MockAPINetwork.swift
//  homeworkTests
//
//  Created by Santiago Carmona on 28/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

@testable import homework
import Foundation

class MockAPINetwork: APINetworkClient {
    let mockJson: MockJson
    init(using mock: MockJson) {
        self.mockJson = mock
    }

    func executeRequest<Response: Codable>(_ endpoint: Endpoint<Response>, completion: @escaping ((Result<Response, Error>) -> Void)) {
        guard let value = mockJson.load(object: Response.self) else {
            completion(.failure(MockJsonError.fileNotFound))
            return
        }
        completion(.success(value))
    }
}

struct MockAPINetworkError: APINetworkClient {
    func executeRequest<Response: Codable>(_ endpoint: Endpoint<Response>, completion: @escaping ((Result<Response, Error>) -> Void)) {
        completion(.failure(NetworkError.invalidStatusCode("-100")))
    }
}
