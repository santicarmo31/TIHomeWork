//
//  JsonLoader.swift
//  homework
//
//  Created by Santiago Carmona on 23/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation

protocol JsonLoadable {
    func loadJson(named: String) -> [String: Any]
    func loadJsonData(named: String) -> Data?
 }

extension Bundle: JsonLoadable {
    private enum Constants {
        static let jsonFileType = "json"
    }

    func loadJsonData(named: String) -> Data? {
        guard let path = path(forResource: named, ofType: Constants.jsonFileType) else {
            assertionFailure("Path noth found for json: \(named)")
            return nil
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch(let error) {
            assertionFailure("Trying to load json named \(named) error: \(error.localizedDescription)")
            return nil
        }
    }

    func loadJson(named: String) -> [String: Any] {

        guard let data = loadJsonData(named: named), let jsonResult = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            assertionFailure("Json file \(named) can't be serialized")
            return [:]
        }
        return jsonResult
    }
}
