//
//  Injectable.swift
//  homework
//
//  Created by Santiago Carmona on 26/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation

protocol Injectable {
    associatedtype Dependencies

    var dependencies: Dependencies { get set }
}

// Helper that makes easier inject dependencies to objects
protocol InitInjectable: Injectable {
    init(dependencies: Dependencies)
}
