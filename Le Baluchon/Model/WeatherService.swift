//
//  WeatherService.swift
//  Le Baluchon
//
//  Created by Morgan on 29/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Request weather condition.
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

    func request(_ body: String, callback: @escaping Callback) {
        task?.cancel()

        let request = createRequest(with: body)
//        let request = URL(string: body)!
        print("<<<<<")
        print(request)
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

                            do {
                                let resource = try JSONDecoder().decode(Weather.self, from: data)
                                print(resource)
                            } catch DecodingError.dataCorrupted(let context) {
                                print(context.debugDescription)
                            } catch DecodingError.keyNotFound(let key, let context) {
                                print("\(key.stringValue) was not found, \(context.debugDescription)")
                            } catch DecodingError.typeMismatch(let type, let context) {
                                print("\(type) was expected, \(context.debugDescription)")
                            } catch DecodingError.valueNotFound(let type, let context) {
                                print("no value was found for \(type), \(context.debugDescription)")
                            } catch {
                                print("Unknown error")
                            }

//                let decoder = JSONDecoder()
//                guard let resource = try? decoder.decode(Weather.self, from: data) else {
//                    callback(false, nil)
//                    return
//                }

//                callback(true, resource)
            }
        }
        task?.resume()
    }
}

// MARK: - Create request

extension WeatherService {

    private func createRequest(with body: String) -> URLRequest {

        let encodedQuery = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let query = YahooWeather.endpoint + encodedQuery
        print(":::::::::")
        print(query)

        let url = URL(string: query)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue

        return request
    }

}
