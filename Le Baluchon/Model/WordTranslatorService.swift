//
//  WordTranslatorService.swift
//  Le Baluchon
//
//  Created by Morgan on 27/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

class WordTranslatorService {

    /// A closure to provide the state of a network call to the ViewController.
    typealias Callback = (Bool, String?) -> Void

    /// A singleton to call WordTranslatorService's methods and properties.
    static var shared = WordTranslatorService()
    private init() {}

    private var task: URLSessionDataTask?
}

extension WordTranslatorService {
    /**
     Call an API to provide a resource.

     - Parameters:
        - value: The resource to process.
        - url: The location of the resources.
        - callback: A closure to provide the state of a network call.
     */
    func query(with value: String, to url: String,  callback: @escaping Callback) {
        task?.cancel()

        let url = URL(string: url + value)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.post.rawValue

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
            guard let resource = try? decoder.decode(WordTranslator.self, from: data) else {
                callback(false, nil)
                return
            }

            guard let translatedText = resource.translations["TranslatedText"] else {
                callback(false, nil)
                return
            }

            DispatchQueue.main.async {
                callback(true, translatedText)
            }
        }
        task?.resume()
    }

}
