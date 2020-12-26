//
//  DateFormatter+ReadableDate.swift
//  homework
//
//  Created by Santiago Carmona on 26/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let longReadable: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
}
