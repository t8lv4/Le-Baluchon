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

/**
 Mirror the YahooWeather JSON response.
 Serve as an intermediate structure to further get the resources.
 */
struct WeatherJSON: Decodable {
    let query: Query

    struct Query: Decodable {
        let results: Channel

        struct Channel: Decodable {
            let channel: Location

            struct Location: Decodable {
                let location: City
                let item: Item

                struct City: Decodable {
                    let city: String
                }

                struct Item: Decodable {
                    let condition: Condition

                    struct Condition: Decodable {
                        let code: String
                        let temp: String
                    }
                }
            }
        }
    }
}

/**
 Define the weather model data structure
 */
struct Weather {
    var city: String
    var code: String
    var temp: String
}

extension Weather {
    init(from service: WeatherJSON) {
        city = service.query.results.channel.location.city
        code = service.query.results.channel.item.condition.code
        temp = service.query.results.channel.item.condition.temp
    }
}
