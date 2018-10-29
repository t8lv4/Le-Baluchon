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
    typealias Callback = (Bool, String?) -> Void

    /// A singleton to call TranslateService's methods and properties.
    static var shared = TranslateService()
    private init() {}

    private var task: URLSessionDataTask?
}

extension TranslateService {
    /**
     Call an API to provide a resource.

     - Parameters:
        - url: The location of the resources.
        - text: The text to translate.
        - callback: A closure to provide the state of a network call.
     */
    func query(to url: String, with text: String,  callback: @escaping Callback) {
        task?.cancel()

        let request = createRequest(with: url, for: text)
        let session = URLSession(configuration: .default)

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

                //            do {
                //                resource = try JSONDecoder().decode(Translate.self, from: data)
                //            } catch DecodingError.dataCorrupted(let context) {
                //                print(context.debugDescription)
                //            } catch DecodingError.keyNotFound(let key, let context) {
                //                print("\(key.stringValue) was not found, \(context.debugDescription)")
                //            } catch DecodingError.typeMismatch(let type, let context) {
                //                print("\(type) was expected, \(context.debugDescription)")
                //            } catch DecodingError.valueNotFound(let type, let context) {
                //                print("no value was found for \(type), \(context.debugDescription)")
                //            } catch {
                //                print("I know not this error")
                //            }

                let decoder = JSONDecoder()
                guard let resource = try? decoder.decode(Translate.self, from: data) else {
                    callback(false, nil)
                    return
                }
                let translatedText = resource.data.translations[0].translatedText

                callback(true, translatedText)
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

