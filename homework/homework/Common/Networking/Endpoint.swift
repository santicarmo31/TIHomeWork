//
//  Endpoint.swift
//  homework
//
//  Created by Santiago Carmona on 23/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
struct Endpoint<Response> {
    let baseURL: String
    let path: String
    let query: [String: String]?
    let method: String
    let headers: [String: String]
    let decoder: JSONDecoder

    init(_ baseURL: String, path: String = "", query: [String: String] = [:], method: String = "GET", headers: [String: String] = [:], decoder: JSONDecoder = .dateDecoder) {
        self.baseURL = baseURL
        self.path = path
        self.query = query
        self.method = method
        self.headers = headers
        self.decoder = decoder
    }

    func urlRequest() -> URLRequest? {
        guard let url = getURL() else { return nil }

        var request = URLRequest(url: url)
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        request.httpMethod = method

        return request
    }
}

private extension Endpoint {
    func getURL() -> URL? {
        var url = URLComponents(string: baseURL)

        if !path.isEmpty {
            url?.path = path
        }

        if query != [:] {
            url?.queryItems = query.map { $0.map { URLQueryItem(name: $0.key, value: $0.value) } }
        }

        return url?.url
    }
}

private extension JSONDecoder {
    static var dateDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            let formats: [DateFormatter] = [.standard, .short]
            for format in formats {
                if let date = format.date(from: dateString) {
                    return date
                }
            }
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
        })
        return jsonDecoder
    }
}
