//
//  WordTranslatorService.swift
//  Le Baluchon
//
//  Created by Morgan on 27/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Build a URLRequest and parse JSON response
struct TranslateService {
    /**
     Build a URL to access Google Translate API
     
     - Parameters:
        - text: The text input by the user
     - Returns: a request
     */
    static func createRequest(for text: String) -> URLRequest {
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let completeURL = GoogleTranslation.url + encodedText!

        let url = URL(string: completeURL)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue

        return request
    }

}

extension TranslateService: ServiceProtocol {

    static func parse(_ data: Data, with decoder: JSONDecoder) -> Any {
        guard let json = try? decoder.decode(Translate.self, from: data) else {
            return (-1)
        }
        let resource = json.data.translations[0].translatedText
        return resource
    }
    
}
