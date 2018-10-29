//
//  Weather.swift
//  Le Baluchon
//
//  Created by Morgan on 22/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/**
JSON structure from YahooWeather
{
    "query": {
        "count": 1,
        "created": "2018-10-29T14:32:23Z",
        "lang": "en-US",
        "results": {
            "channel": {
                "location": {
                    "city": "Paris"
                },
                "item": {
                    "condition": {
                        "code": "26",
                        "temp": "5"
                    }
                }
            }
        }
    }
}
*/

struct Weather: Codable {
    let query: Query

    struct Query: Codable {
        let results: Channel

        struct Channel: Codable {
            let channel: Location

            struct Location: Codable {
                let location: City
                let item: Item

                struct City: Codable {
                    let city: String
                }

                struct Item: Codable {
                    let condition: Condition

                    struct Condition: Codable {
                        let code: String
                        let temp: String
                    }
                }
            }
        }
    }
}
