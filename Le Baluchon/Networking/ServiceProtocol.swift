//
//  ServiceProtocol.swift
//  Le Baluchon
//
//  Created by Morgan on 16/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Parse data using a `JSONDecoder`
protocol ServiceProtocol {
    /**
     Decode an API response and return the requested resource
     - Parameters:
        - data: data to decode
        - decoder: JSON decoder
     */
    static func parse(_ data: Data, with decoder: JSONDecoder) -> Any
}
