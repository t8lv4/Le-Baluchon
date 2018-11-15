//
//  WordTranslatorService.swift
//  Le Baluchon
//
//  Created by Morgan on 27/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Request a word translation
class TranslateService {
    /// A closure to provide the state of a network call to the TranslateViewController.
    typealias Callback = (Bool, String?) -> Void

}

extension TranslateService {
    /**
     Decode an API response and return the requested resource
     - Parameters:
     - data: The data to decode
     - decoder: The JSON decoder
     - callback: A closure of type `(Bool, Double?) -> Void`
     */
    static func parse(_ data: Data, with decoder: JSONDecoder, callback: @escaping Callback) -> Any {
        guard let json = try? decoder.decode(Translate.self, from: data) else {
            callback(false, nil)
            return (-1)
        }
        let resource = json.data.translations[0].translatedText
        return resource
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
    static func createRequest(with url: String, for text: String) -> URLRequest {
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let completeURL = url + encodedText!

        let url = URL(string: completeURL)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue

        return request
    }

}
