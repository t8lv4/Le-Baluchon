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

    private var task: URLSessionDataTask?

}

// MARK: - Request

extension WeatherService {

    /**
     Request weather condition from YAHOOWeather service.
     - Parameters:
     - body: A query in a YQL query format
     - callback: A closure to provide the state of a network call
     */
    func request(_ body: String, callback: @escaping Callback) {
        task?.cancel()

        let request = createRequest(with: body)
        let session = URLSession(configuration: .default)

        task = session.dataTask(with: request) {(data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }

                let decoder = JSONDecoder()
                guard let resource = try? decoder.decode(WeatherJSON.self, from: data) else {
                    callback(false, nil)
                    return
                }

                let weatherCondition = Weather(from: resource)

                callback(true, weatherCondition)
            }
        }
        task?.resume()
    }
}

// MARK: - Create request

extension WeatherService {

    /**
     Build a URL to access YahooWeather conditions
     */
    private func createRequest(with body: String) -> URLRequest {

        let encodedQuery = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let query = YahooWeather.endpoint + encodedQuery

        let url = URL(string: query)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue

        return request
    }

}
