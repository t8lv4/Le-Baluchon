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

    /// A closure to provide the state of a network call to the ConvertViewController.
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
     */
    func query(API: WebService, input: AnyObject, callback: @escaping Callback) {
        if API != .YahooWeather { task?.cancel() }

        switch API {
        case .Fixer:
            request = ConvertService.createRequest(with: Fixer.url)
        case .GoogleTranslate:
            request = TranslateService.createRequest(with: GoogleTranslation.url, for: input as! String)
        case .YahooWeather:
            request = WeatherService.createRequest(for: input as! String)
        }

        guard let request = request else { print("Unable to create request"); return }
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
                case .Fixer:
                    // trouve -1 => retourner callback(false, nil) else
                    self?.resource = ConvertService.parse(data, with: decoder, callback: callback)
                case .GoogleTranslate:
                    self?.resource = TranslateService.parse(data, with: decoder, callback: callback)
                case .YahooWeather:
                    self?.resource = WeatherService.parse(data, with: decoder, callback: callback)
                }

                callback(true, self?.resource)
            }
        }
        task?.resume()
    }

}
