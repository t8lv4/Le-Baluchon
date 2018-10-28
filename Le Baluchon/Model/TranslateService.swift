//
//  WordTranslatorService.swift
//  Le Baluchon
//
//  Created by Morgan on 27/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

class TranslateService {

    /// A closure to provide the state of a network call to the ViewController.
    typealias Callback = (Bool, String?) -> Void

    /// A singleton to call WordTranslatorService's methods and properties.
    static var shared = TranslateService()
    private init() {}

    private var task: URLSessionDataTask?
}

extension TranslateService {
    /**
     Call an API to provide a resource.

     - Parameters:
        - text: The text to translate.
        - url: The location of the resources.
        - callback: A closure to provide the state of a network call.
     */
    func query(to url: String, with text: String,  callback: @escaping Callback) {
        task?.cancel()

        let request = createRequest(with: url, for: text)

        let session = URLSession(configuration: .default)
        task = session.dataTask(with: request) {(data, response, error) in
            guard let data = data, error == nil else {
                print("//////////")
                callback(false, nil)
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("''''''''''''''''''''")
                callback(false, nil)
                return
            }

            let decoder = JSONDecoder()
            guard let resource = try? decoder.decode(Translate.self, from: data) else {
                print("---------")
                callback(false, nil)
                return
            }

            guard let translatedText = resource.translatedText else {
                print("+++++++++")

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

extension TranslateService {

    func createRequest(with url: String, for text: String) -> URLRequest {
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = text.data(using: .utf8)

        return request
    }

}

