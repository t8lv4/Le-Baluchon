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
    typealias Callback = (Bool, Double?) -> Void

    /// A singleton to call CurrencyConverterService's methods and properties.
    static var shared = CurrencyConverterService()
    private init() {}

    private var task: URLSessionDataTask?

}

extension CurrencyConverterService {
    
    /**
     Call an API to provide a resource.

     - Parameters:
        - value: The resource to process.
        - url: The location of the resources.
        - callback: A closure to provide the state of a network call.
     */
    func query(to url: String,  callback: @escaping Callback) {
        task?.cancel()

        let url = URL(string: url)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue

        let session = URLSession(configuration: .default)
        task = session.dataTask(with: urlRequest) {(data, response, error) in
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
                guard let resource = try? decoder.decode(CurrencyConverter.self, from: data) else {
                    callback(false, nil)
                    return
                }

                guard let rate = resource.rates["USD"] else {
                    callback(false, nil)
                    return
                }
                
                callback(true, rate)
            }
        }
        task?.resume()
    }

}
