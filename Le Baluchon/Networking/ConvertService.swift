//
//  QueryService.swift
//  Le Baluchon
//
//  Created by Morgan on 23/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Convert currency.
class ConvertService {

    /// A closure to provide the state of a network call to the ConvertViewController.
    typealias Callback = (Bool, Double?) -> Void

    /// A singleton to call CurrencyConverterService's methods and properties.
    static var shared = ConvertService()
    private init() {}

    private var task: URLSessionDataTask?
    
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }

}

extension ConvertService {
    
    /**
     Call an API to provide a resource.

     - Parameters:
        - value: The resource to process
        - url: The location of the resources
        - callback: A closure to provide the state of a network call
     */
    func query(to url: String,  callback: @escaping Callback) {
        task?.cancel()

        // switch pour request avec les bons param selon les services
        let request = createRequest(with: url)
        
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
                guard let resource = try? decoder.decode(Convert.self, from: data) else {
                    callback(false, nil)
                    return
                }

                guard let rate = resource.rates["USD"] else {
                    callback(false, nil)
                    return
                }

//                switch typeduservice { // pour parser -> data
//                case meteo:
//                    call method A
//                case trad.:
//                    call B
//                case convert:
//                    call C
//                }
                
                callback(true, rate)
            }
        }
        task?.resume()
    }

}

extension ConvertService {
    /**
     Create request with a URL.
     - Parameters:
        - url: The resource location
     */
    private func createRequest(with url: String) -> URLRequest {
        let url = URL(string: url)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue

        return urlRequest
    }
}
