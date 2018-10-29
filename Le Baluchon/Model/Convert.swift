//
//  CurrencyConverter.swift
//  Le Baluchon
//
//  Created by Morgan on 22/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Convert from Euro to US Dollar
struct Convert: Decodable {
    let rates: [String: Double]
}

extension Convert {

    /**
     Convert a value according to a given rate. Return a String rounded to 2 decimal places.
     */
    static func convert(_ value: Double, with rate: Double) -> String {
        let convertedValue = (value / rate)

        return String(format: "%.2f", convertedValue)
    }
    
}
