//
//  WeatherService.swift
//  Le Baluchon
//
//  Created by Morgan on 29/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Build a URLRequest and parse JSON response
struct WeatherService {
    /**
     Build a URL to access YahooWeather API

     - Parameters:
        - city: The user current location
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

extension WeatherService: ServiceProtocol {
    static func parse(_ data: Data, with decoder: JSONDecoder) -> Any {
        guard let json = try? decoder.decode(WeatherJSON.self, from: data) else {
            return (-1)
        }

        let resource = Weather(from: json)
        return resource
    }
}
