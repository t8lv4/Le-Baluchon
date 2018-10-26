//
//  QueryService.swift
//  Le Baluchon
//
//  Created by Morgan on 23/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Convert currency.
class CurrencyConverterService {

    /// A closure to provide the state of a network call to the ViewController.
    typealias Callback = (Bool, Any?) -> Void

    /// A singleton to call CurrencyConverterService's methods and properties.
    static var shared = CurrencyConverterService()
    private init() {}

    private var task: URLSessionDataTask?

    /**
     Call an API to provide a resource.

     - Parameters:
        - url: The location of the resources.
        - values: Append these values to the url if needed, default is empty string.
        - method: HTTP methods, default is "GET".
        - callback: A closure to provide the state of a network call.
     */
    func query(url: String, values: String = "", method: HTTPMethod = .get, callback: @escaping Callback) {
        task?.cancel()

        let url = URL(string: url + values)!
        print(url)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        let session = URLSession(configuration: .default)
        task = session.dataTask(with: urlRequest) {(data, response, error) in
            guard let data = data, error == nil else {
                callback(false, nil)
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(false, nil)
                return
            }

            let decoder = JSONDecoder()
            guard let resource = try? decoder.decode(CurrencyConverter.self, from: data) else {
                callback(false, nil)
                return
            }

            guard let rate = resource.rates["USD"] else {
                callback(false, nil)
                return
            }

            DispatchQueue.main.async {
                callback(true, rate)
            }
        }
        task?.resume()
    }

}
