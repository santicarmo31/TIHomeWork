//
//  MockTripListNetwork.swift
//  homework
//
//  Created by Santiago Carmona on 27/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
struct MockTripListNetwork: APINetworkClient {
    func executeRequest<Response: Codable>(_ endpoint: Endpoint<Response>, completion: @escaping ((Result<Response, Error>) -> Void)) {
        guard let data = Bundle.main.loadJsonData(named: "MockGraphql") else {
            completion(.failure(NetworkError.malformedURLRequest))
            return
        }
        do {
            let value = try JSONDecoder.dateDecoder.decode(Response.self, from: data)
            completion(.success(value))

        } catch let error {
            print(error)
            completion(.failure(error))
        }
    }
}
