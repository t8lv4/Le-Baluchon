//
//  QueryService.swift
//  Le Baluchon
//
//  Created by Morgan on 23/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

class QueryService {

    typealias Callback = (Bool, Any?) -> Void

    static var shared = QueryService()
    private init() {}

    private var data = Data()
    private var task: URLSessionDataTask?
    private var callback: Callback?
    

    func query(url: String, values: String = "", method: HTTPMethod = .get, callback: @escaping Callback) {
        // créer url: URL
        let url = URL(string: url + values)!
        print(url)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) {(data, response, error) in
            print(data as Any)

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
        task.resume()
    }

}
