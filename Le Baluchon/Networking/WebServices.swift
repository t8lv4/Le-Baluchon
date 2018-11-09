//
//  WebServices.swift
//  Le Baluchon
//
//  Created by Morgan on 22/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

enum WebService: String {

    case Fixer = "Fixer", GoogleTranslate = "GoogleTranslate", YahooWeather = "YahooWeather"
    
}

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

    /// The place where we want weather forecast resources, express in a YQL format
    var place: String

    /// YahooWeather APIs URL
    static let endpoint = "https://query.yahooapis.com/v1/public/yql?"
    /// Query city name, temperature and weather condition code
    static let query = "q=select location.city, item.condition.temp, item.condition.code from weather.forecast "
    /// Get temperature value in Celsius and response as JSON
    static let parameters = "and u='c'&format=json"

}

extension YahooWeather {
    /// Construct a query for a city (YQL format)
    init(city: Any) {
        place = "where woeid in (SELECT woeid FROM geo.places WHERE text=\"\(city)\")"
    }
}
