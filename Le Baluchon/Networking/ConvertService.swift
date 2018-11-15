//
//  QueryService.swift
//  Le Baluchon
//
//  Created by Morgan on 23/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Convert currency
class ConvertService {

    /// A closure to provide the state of a network call to the ConvertViewController.
    typealias Callback = (Bool, Double?) -> Void

}

extension ConvertService {

    /**
     Decode an API response and return the requested resource
     - Parameters:
        - data: The data to decode
        - decoder: The JSON decoder
        - callback: A closure of type `(Bool, Double?) -> Void`
     */
    static func parse(_ data: Data, with decoder: JSONDecoder, callback: @escaping Callback) -> Any {
        guard let json = try? decoder.decode(Convert.self, from: data) else {
            callback(false, nil)
            return (-1)
        }

        guard let resource = json.rates["USD"] else {
            callback(false, nil)
            return (-2)
        }

        return resource
    }

}

extension ConvertService {
    /**
     Create request with a URL.
     - Parameters:
        - url: The resource location
     */
    static func createRequest(with url: String) -> URLRequest {
        let url = URL(string: url)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue

        return urlRequest
    }
}
