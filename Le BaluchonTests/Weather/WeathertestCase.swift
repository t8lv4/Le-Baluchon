//
//  WeathertestCase.swift
//  Le BaluchonTests
//
//  Created by Morgan on 04/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import XCTest

@testable import Le_Baluchon

class WeatherServiceTests: XCTestCase {
    func testCoordinatesAddingCoordinatesToCitiesNewEntryIsAdded() {
        //given
        let coordinates = (48.856614, 2.3522219)
        //when
        Places.addCurrentLocation(coordinates)
        let newEntry = Places.cities[DictionaryKeys.currentLocation] as! (Double, Double)
        //then
        XCTAssertEqual(Places.cities.count, 2)
        XCTAssertEqual(newEntry.0, 48.856614)
        XCTAssertEqual(newEntry.1, 2.3522219)
    }

    func testAnyValidConditionCodeGetWeatherNotNil() {
        // YahooWeather condition code goes up to 47
        // as of november 2018
        let code = Int.random(in: 0...47)

        let condition = Weather.getWeatherIcon(condition: code)

        XCTAssertNotNil(condition)
    }

    func testConditionCode3200GetWeatherReturnQuestionMark() {
        let code = 3200

        let condition = Weather.getWeatherIcon(condition: code)

        XCTAssertEqual(condition, "?")
    }

    func testConditionCodeDefaultCaseGetWeatherReturnQuestionMark() {
        let code = 50

        let condition = Weather.getWeatherIcon(condition: code)

        XCTAssertEqual(condition, "?")
    }

    func testConditionCodeGetWeatherIconReturnNameOfIcon() {
    //given
    let code = 0
    //when
    let condition = Weather.getWeatherIcon(condition: code)
    //then
    XCTAssertEqual(condition, "tornade")
    }
}
