//
//  QueryService.swift
//  Le Baluchon
//
//  Created by Morgan on 23/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Build a URLRequest and parse JSON response
struct ConvertService {
    /**
     Create request with a URL.
     */
    static func createRequest() -> URLRequest {
        let url = URL(string: Fixer.url)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue

        return urlRequest
    }

}

extension ConvertService: ServiceProtocol {

    static func parse(_ data: Data, with decoder: JSONDecoder) -> Any {
        guard let json = try? decoder.decode(Convert.self, from: data) else {
            return -1
        }

        guard let resource = json.rates[conversionRates.USD.rawValue] else {
            return -2
        }

        return resource
    }

}
