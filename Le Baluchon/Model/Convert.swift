//
//  CurrencyConverter.swift
//  Le Baluchon
//
//  Created by Morgan on 22/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/*
 JSON structure from Fixer
 {
    "success": true,
    "timestamp": 1540538946,
    "base": "EUR",
    "date": "2018-10-26",
    "rates": {
        "USD": 1.138064
    }
 }
 */

/// List targeted conversion rates
enum ConversionRates: String {
    case USD = "USD"
}

/// Convert from Euro to US Dollar
struct Convert: Decodable {
    let rates: [String: Double]
}

extension Convert {
    /**
     Convert a value according to a given rate

     - Returns:
        - a String rounded to 2 decimal places
     */
    static func convert(_ value: Double, with rate: Double) -> String {
        let convertedValue = (value / rate)

        return String(format: "%.2f", convertedValue)
    }
}
