//
//  MockJson.swift
//  homeworkTests
//
//  Created by Santiago Carmona on 28/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

@testable import homework
import Foundation

private class Mock { }

/* ☢️ WARNING ☢️
    Don't modify existing JSON files since those are already being used in tests,
    please create new ones with the required data
 */
enum MockJson: String {
    // MARK: - Json files -
    case graphql = "MockGraphql"
    case graphqlSort = "MockGraphqlSort"

    func loadData() -> Data? {
        return Bundle(for: Mock.self).loadJsonData(named: rawValue)        
    }

    func load<Type: Codable>(object: Type.Type, decoder: JSONDecoder = .dateDecoder) -> Type? {
        guard let data = loadData() else {
            return nil
        }
        do {
            return try decoder.decode(object, from: data)
        } catch let error {
            print(error)
            return nil
        }
    }
}

enum MockJsonError: Error {
    case fileNotFound
}
