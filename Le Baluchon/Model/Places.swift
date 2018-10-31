//
//  Places.swift
//  Le Baluchon
//
//  Created by Morgan on 29/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Define places to query wheather conditions
struct Places {
    /**
     A dictionnary of cities.

     Values are either coordinates as (lat, long), litteral names, or WOEID (cf YahooWeather API)
     - Note:
     If using a litteral name, it must conform to the YahooWeather YQL query format
    */
    static var cities: [String: Any] = ["Paris": (48.862725, 2.287592), "New-York": "new-york, ny"]

}

extension Places {
    /**
     Add the entry "currentLocation" to the `cities` dictionnary.
     - Parameters:
        - coordinates: latitude and longitude
     */
    static func addCurrentLocation(_ coordinates: (Double, Double)) {
        Places.cities["currentLocation"] = coordinates
    }

}
