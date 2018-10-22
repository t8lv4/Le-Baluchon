//
//  ResourcesURL.swift
//  Le Baluchon
//
//  Created by Morgan on 22/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Build URLs according to web services
struct ResourceLocator {
    var url: String

    init(with FixerURL: String) {
        url = FixerURL
    }

    init(with GoogleURL: String, text: String) {
        url = String(GoogleURL + text)
    }
}
