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

// MARK: Intermediate type

/**
 Mirror the YahooWeather JSON response.
 Intermediate structure to further get the resources.
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

// MARK: - Model

/**
 Define the weather model data structure
 */
struct Weather {

    var city: String
    /**
     Weather condition code
     - Note:
        - This code is provided by YahooWeather
        - Mapped in `getWeatherIcon(condition:) -> String`
     */
    var code: String
    /// Temperature in °C (cf YahooWeather request parameters)
    var temp: String

}

extension Weather {

    init(from service: WeatherJSON) {
        city = service.query.results.channel.location.city
        code = service.query.results.channel.item.condition.code
        temp = service.query.results.channel.item.condition.temp
    }

}

extension Weather {
    /**
     Return a weatherIcon name according to a YahooWeather condition code.
     - parameters:
        - condition: The code provided by YahooWeather
     - returns: The name of a weather icon
     - note: As of October 2018, YahooWeather code are provided at `https://developer.yahoo.com/weather/documentation.html`.
     */
    static func getWeatherIcon(condition: Int) -> String {
        switch condition {
        case 0...2, 19:
            return "tornade"

        case 3, 4, 45, 47:
            return "orage"

        case 5...7, 13, 14, 18, 41...43:
            return "averseNeige"

        case 8...10, 17:
            return "pluie"

        case 11, 12, 35, 40:
            return "averse"

        case 15, 16:
            return "neige"

        case 20...22:
            return "brouillard"

        case 23, 24:
            return "ventFort"

        case 26:
            return "couvert"

        case 27, 29:
            return "nuageuxNuit"

        case 28, 30, 44:
            return "nuageuxJour"

        case 31, 33:
            return "nuitClaire"

        case 32, 34:
            return "jourClair"

        case 37...39:
            return "orageux"

        case 3200:
            return "?"

        default:
            return "?"


        }
    }

}
