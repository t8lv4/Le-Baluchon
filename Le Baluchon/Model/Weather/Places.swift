//
//  Places.swift
//  Le Baluchon
//
//  Created by Morgan on 29/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// List `cities` dictionary keys
enum DictionaryKeys {
    case newYork
    case currentLocation
}

/// Define places to query wheather conditions
struct Places {
    /**
     A dictionnary of cities

     Values are either coordinates as (lat, long), litteral names, or WOEID (cf YahooWeather API)
     - Note:
     If using a litteral name, it must conforms to the YahooWeather YQL query format
    */
    static var cities: [DictionaryKeys: Any] = [DictionaryKeys.newYork: "new-york, ny"]

}

extension Places {
    /**
     Add the entry "currentLocation" to the `cities` dictionnary
     - Parameters:
        - coordinates: latitude and longitude
     - Note:
        Parameters types could also be litteral names or WEOID, as long as they conform to the YahooWeather YQL
     */
    static func addCurrentLocation(_ coordinates: (Double, Double)) {
        Places.cities[DictionaryKeys.currentLocation] = coordinates
    }
}
