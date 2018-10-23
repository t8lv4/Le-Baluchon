//
//  QueryService.swift
//  Le Baluchon
//
//  Created by Morgan on 23/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

class QueryService {

    static var shared = QueryService()
    private init() {}

    var data = Data()
    private var task: URLSessionDataTask?
    

    func queryService(url: String, values: String = "", method: HTTPMethod = .get) -> Data? {
        // créer url: URL
        let url = URL(string: url + values)!
        print(url)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) {(data, response, error) in
            print(data)
        }
        task.resume()


        return data
    }

    func parseData(data: Data) {
    }

    

//    private static func createQuoteRequest() -> URLRequest {
//        //create request
//        var request = URLRequest(url: quoteURL)
//        //attach http method
//        request.httpMethod = "POST"
//
//        //create body
//        let body = "method=getQuote&format=json&lang=en"
//        //encode body using utf8 and attach it to request
//        request.httpBody = body.data(using: .utf8)
//
//        return request
//    }

}

/// List HTTP method
enum HTTPMethod: String {
    case post = "POST", get = "GET"
}
