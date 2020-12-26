//
//  Injectable.swift
//  homework
//
//  Created by Santiago Carmona on 26/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation

@dynamicMemberLookup
protocol Injectable {
    associatedtype Dependencies

    var dependencies: Dependencies { get mutating set }
}

extension Injectable {
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Dependencies, T>) -> T {
        get { self[keyPath: (\Self.dependencies).appending(path: keyPath)] }
        set { self[keyPath: (\Self.dependencies).appending(path: keyPath)] = newValue }
    }
}

// Helper that makes easier inject dependencies to objects
protocol InitInjectable: Injectable {
    init(dependencies: Dependencies)
}
