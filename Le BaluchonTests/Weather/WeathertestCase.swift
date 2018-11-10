//
//  WeathertestCase.swift
//  Le BaluchonTests
//
//  Created by Morgan on 04/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import XCTest

@testable import Le_Baluchon

//class WeatherServiceTests: XCTestCase {
//
//    func testRequestShouldPostFailedCallbackIfError() {
//        // Given
//        let weatherService = WeatherService(
//            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
//
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherService.query(for: "Paris") { (success, weatherCondition) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(weatherCondition)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testRequestShouldPostFailedCallbackIfNoData() {
//        // Given
//        let weatherService = WeatherService(
//            session: URLSessionFake(data: nil, response: nil, error: nil))
//        
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherService.query(for: "Paris") { (success, weatherCondition) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(weatherCondition)
//            expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testRequestShouldPostFailedCallbackIfIncorrectResponse() {
//        // Given
//        let weatherService = WeatherService(
//            session: URLSessionFake(
//                data: FakeResponseData.weatherCorrectData,
//                response: FakeResponseData.responseKO,
//                error: nil))
//
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherService.query(for: "Paris") { (success, weatherCondition) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(weatherCondition)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testRequestShouldPostFailedCallbackIfIncorrectData() {
//        // Given
//        let weatherService = WeatherService(
//            session: URLSessionFake(
//                data: FakeResponseData.IncorrectData,
//                response: FakeResponseData.responseOK,
//                error: nil))
//
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherService.query(for: "Paris") { (success, weatherCondition) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(weatherCondition)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testRequestShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
//        // Given
//        let weatherService = WeatherService(
//            session: URLSessionFake(
//                data: FakeResponseData.weatherCorrectData,
//                response: FakeResponseData.responseOK,
//                error: nil))
//
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherService.query(for: "Paris") { (success, weatherCondition) in
//            // Then
//            XCTAssertTrue(success)
//            XCTAssertNotNil(weatherCondition)
//
//            let city = "Paris"
//            let code = "26"
//            let temp = "5"
//
//            XCTAssertEqual(city, weatherCondition?.city)
//            XCTAssertEqual(code, weatherCondition?.code)
//            XCTAssertEqual(temp, weatherCondition?.temp)
//
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//}
//
//// test Places and Weather methods
//extension WeatherServiceTests {
//
//    func testCoordinatesAddingCoordinatesToCitiesNewEntryIsAdded() {
//        //given
//        let coordinates = (48.856614, 2.3522219)
//        //when
//        Places.addCurrentLocation(coordinates)
//        let newEntry = Places.cities["currentLocation"] as? (Double, Double)
//        //then
//        XCTAssertEqual(Places.cities.count, 2)
//        XCTAssertEqual(newEntry?.0, 48.856614)
//        XCTAssertEqual(newEntry?.1, 2.3522219)
//    }
//
//    func testCodeGetWeatherIconReturnNameOfIcon() {
//    //given
//    let code = 0
//    //when
//    let condition = Weather.getWeatherIcon(condition: code)
//    //then
//    XCTAssertEqual(condition, "tornade")
//    }
//
//}
