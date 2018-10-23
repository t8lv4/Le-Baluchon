//
//  ResourcesURL.swift
//  Le Baluchon
//
//  Created by Morgan on 22/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Build URLs
struct ResourceLocator {
    var url: String

    init(with URL: String) {
        url = URL
    }

    init(with URL: String, query: String) {
        url = String(URL + query)
    }
}
