//
//  MockListTripsJsonLoader.swift
//  homeworkTests
//
//  Created by Santiago Carmona on 27/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

@testable import homework
import Foundation

class EmptyMockListTripsJsonLoader: JsonLoadable {
    func loadJson(named: String) -> [String : Any] {
        return [:]
    }

    func loadJsonData(named: String) -> Data? {
        return nil
    }
}
