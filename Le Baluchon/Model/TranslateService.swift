//
//  WordTranslatorService.swift
//  Le Baluchon
//
//  Created by Morgan on 27/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Request a word translation and return a translated text
class TranslateService {

    /// A closure to provide the state of a network call to the ViewController.
    typealias Callback = (Bool, Translate?) -> Void

    /// A singleton to call TranslateService's methods and properties.
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
        print("this is a request URL: \(request)")

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

//            var t = resource.data.translations[0]

//            guard var translatedText = resource.data.translations[0] else {
//                print("+++++++++")
//
//                callback(false, nil)
//                return
//            }

            DispatchQueue.main.async {
                callback(true, resource)
            }
        }
        task?.resume()
    }

}

extension TranslateService {

    /**
     Create request with a URL and a user input text
     - Parameters:
        - url: The resource location
        - text: The text input by the user
     - Returns: a request
     */
    func createRequest(with url: String, for text: String) -> URLRequest {
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let completeURL = url + encodedText!

        let url = URL(string: completeURL)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        return request
    }

}

