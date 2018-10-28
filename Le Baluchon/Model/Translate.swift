//
//  WordTranslator.swift
//  Le Baluchon
//
//  Created by Morgan on 25/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

struct Translate: Decodable {
    
    var data: Translations

    struct Translations: Decodable {
        var translations: [String: String]
    }

}


//{
//    "data": {
//        "translations": [
//        {
//        "translatedText": "Bonjour Monde!"
//        }
//        ]
//    }
//}
