//
//  JsonLoader.swift
//  homework
//
//  Created by Santiago Carmona on 23/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation

extension Bundle {
    private enum Constants {
        static let jsonFileType = "json"
    }

    func loadJson(named: String) -> [String: Any] {
        guard let path = path(forResource: named, ofType: Constants.jsonFileType) else {
            assertionFailure("Path noth found for json: \(named)")
            return [:]
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            guard let jsonResult = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                assertionFailure("Json file \(named) can't be serialized")
                return [:]
            }
            return jsonResult
        } catch(let error) {
            assertionFailure("Trying to load json named \(named) error: \(error.localizedDescription)")
            return [:]
        }
    }
}
