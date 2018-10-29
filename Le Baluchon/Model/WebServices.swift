//
//  WebServices.swift
//  Le Baluchon
//
//  Created by Morgan on 22/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

// MARK: - Fixer

/// Hold access to Fixer API resources
struct Fixer {

    static private let endpoint = "http://data.fixer.io/api/latest"
    static private let accessKey = "?access_key=\(APIKeys.Fixer)"
    static private let parameters = "&symbols=USD"

    /// return Fixer resources location
    static var url: String { return Fixer.endpoint + Fixer.accessKey + Fixer.parameters }

}

// MARK: - Google Translation

/// Hold access to Google Translation API resources
struct GoogleTranslation {

    static private let endpoint = "https://translation.googleapis.com/language/translate/v2"
    static private let accessKey = "?key=\(APIKeys.GoogleTranslation)"
    static private let parameters = "&source=fr&target=en&format=text&q="

    /// return Google Translation service location
    static var url: String {
        return GoogleTranslation.endpoint + GoogleTranslation.accessKey + GoogleTranslation.parameters
    }

}

// MARK: - Yahoo Weather

/// Hold access to Yahoo Weather API resources.
struct YahooWeather {

    static let endpoint = "https://query.yahooapis.com/v1/public/yql?"
    static private let query = "q=select location.city, item.condition.temp, item.condition.code from weather.forecast "
    static private let places = "where woeid in (SELECT woeid FROM geo.places WHERE text=\"\(Places.Paris)\")"
    /// Get temperature value in Celsius and response in JSON
    static private let parameters = "and u='c'&format=json"
    
    static let plainURL = "https://query.yahooapis.com/v1/public/yql?q=select%20location.city%2C%20item.condition.temp%2C%20item.condition.code%20from%20weather.forecast%20where%20woeid%20in%20(SELECT%20woeid%20FROM%20geo.places%20WHERE%20text%3D%22(48.862725%2C%202.287592)%22)%20and%20u%3D'c'&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"

    static var url: String {
        return YahooWeather.query
            + YahooWeather.places
            + YahooWeather.parameters
    }

}
