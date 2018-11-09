//
//  WeatherService.swift
//  Le Baluchon
//
//  Created by Morgan on 29/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Request weather conditions.
class WeatherService {

    /// A closure to provide the state of a network call to the WeatherViewController.
    typealias Callback = (Bool, Weather?) -> Void

    /// A singleton to call WheatherService methods and properties.
    static var shared = WeatherService()
    private init() {}

}

// MARK: - Parse

extension WeatherService {

    /**
     Decode an API response and return the requested resource
     - Parameters:
     - data: The data to decode
     - decoder: The JSON decoder
     - callback: A closure of type `(Bool, Double?) -> Void`
     */
    static func parse(_ data: Data, with decoder: JSONDecoder, callback: Callback) -> Any {
        guard let json = try? decoder.decode(WeatherJSON.self, from: data) else {
            callback(false, nil)
            return (-1)
        }

        let resource = Weather(from: json)
        return resource
    }

}

// MARK: - Create request

extension WeatherService {

    /**
     Build a URL to access YahooWeather API
     */
    static func createRequest(for city: String) -> URLRequest {
        let query = YahooWeather.query + city + YahooWeather.parameters

        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let stringURL = YahooWeather.endpoint + encodedQuery

        let url = URL(string: stringURL)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue

        return request
    }

}
