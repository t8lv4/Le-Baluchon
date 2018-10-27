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
    static var url: String { return String(Fixer.endpoint + Fixer.accessKey + Fixer.parameters) }

}

// MARK: - Google Translation

/// Hold access to Google Translation API resources
struct GoogleTranslation {

    static private let endpoint = "https://translation.googleapis.com/language/translate/v2"
    static private let accessKey = "?key=\(APIKeys.GoogleTranslation)"
    static private let parameters = "&source=fr&target=en&format=text&q="

    /// return Google Translation service location
    static var url: String {
        return String(GoogleTranslation.endpoint + GoogleTranslation.accessKey + GoogleTranslation.parameters)
    }

}

// MARK: - Yahoo Weather

/// Hold access to Yahoo Weather API resources
struct YahooWeather {

    let endpoint = "https://query.yahooapis.com/v1/public/yql"
    let parameter = "select wind from weather.forecast where woeid=2460286"

}
