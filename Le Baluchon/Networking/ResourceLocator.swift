//
//  ResourcesURL.swift
//  Le Baluchon
//
//  Created by Morgan on 22/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Build URLs as Strings
struct ResourceLocator {
    /// Resource location
    var url: String

}

extension ResourceLocator {
    /**
     Build resource location

     - Parameters:
        - URL: resource location
        - query: data to be sent
     */
    init(with URL: String, query: String) {
        url = String(URL + query)
    }

}
