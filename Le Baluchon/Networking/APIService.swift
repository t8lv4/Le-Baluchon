//
//  APIService.swift
//  Le Baluchon
//
//  Created by Morgan on 09/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Perform API requests
class APIService {

    /// A closure to provide the state of a network call to the ViewControllers
    typealias Callback = (Bool, Any?) -> Void
    var request: URLRequest?
    /// Decoded data from an API
    var resource: Any?

    static var shared = APIService()
    private init() {}

    private var task: URLSessionDataTask?

    // for testing purpose
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }

}

extension APIService {

    /**
     Perform a session dataTask with URLRequest from different APIs

     - Parameters:
        - API: APIs used by Le Baluchon
        - input: Any value input by the user and used by the API to provide the expected resource
        - callback: Provides the state of the session and returns decoded data to the VCs

     - Note:
     As of november 2018, any API involved in Le Balluchon takes a String as an input type.
     To allow flexibility when calling `query` and avoid passing dummy value to the `input` parameter,
     `input` default value is an empty string.
     */
    func query(API: WebService, input: String = "", callback: @escaping Callback) {
        if API != .yahooWeather { task?.cancel() }

        guard let request = getRequest(API: API, for: input) else {
            callback(false, nil)
            return
        }

        task = session.dataTask(with: request) { [weak self] (data, response, error) in
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
                switch API {
                case .fixer:
                    if ConvertService.parse(data, with: decoder) as? Int == -1 ||
                        ConvertService.parse(data, with: decoder) as? Int == -2 {
                        callback(false, nil)
                        return
                    }
                    self?.resource = ConvertService.parse(data, with: decoder)

                case .googleTranslate:
                    if TranslateService.parse(data, with: decoder) as? Int == -1 {
                        callback(false, nil)
                        return
                    }
                    self?.resource = TranslateService.parse(data, with: decoder)
                    
                case .yahooWeather:
                    if WeatherService.parse(data, with: decoder) as? Int == -1 {
                        callback(false, nil)
                        return
                    }
                    self?.resource = WeatherService.parse(data, with: decoder)
                }

                callback(true, self?.resource)
            }
        }
        task?.resume()
    }

}

extension APIService {
    /**
     Call `createRequest` for each API

     - Parameters:
        - API: APIs used by Le Baluchon
        - input: Any value input by the user and used by the API to provide the expected resource

     - Note:
     As of november 2018, any API involved in Le Balluchon takes a String as an input type.
     To allow flexibility when calling `query` and avoid passing dummy value to the `input` parameter,
     `input` default value is an empty string.
     */
    private func getRequest(API: WebService, for input: String = "") -> URLRequest? {
        switch API {
        case .fixer:
            request = ConvertService.createRequest()
        case .googleTranslate:
            request = TranslateService.createRequest(for: input)
        case .yahooWeather:
            request = WeatherService.createRequest(for: input)
        }

        return request
    }

}
