//
//  WordTranslator.swift
//  Le Baluchon
//
//  Created by Morgan on 25/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/*
JSON structure from Google Translate

{
    "data": {
        "translations": [
        {
        "translatedText": "Bonjour Monde!"
        }
        ]
    }
}
 */

/**
 Reflect the Google Translate JSON structure to decode Google response.
*/
struct Translate: Codable {

    let data: Translations

    struct Translations: Codable {
        var translations: [TranslatedText]

        struct TranslatedText: Codable {
            var translatedText: String
        }
    }
    
}
