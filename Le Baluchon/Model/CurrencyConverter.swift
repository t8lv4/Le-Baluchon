//
//  CurrencyConverter.swift
//  Le Baluchon
//
//  Created by Morgan on 22/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Convert from Euro to US Dollar
struct CurrencyConverter: Decodable {
    let rates: [String: Double]
}
