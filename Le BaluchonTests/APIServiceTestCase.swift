//
//  APIServiceTestCase.swift
//  Le BaluchonTests
//
//  Created by Morgan on 10/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation
import XCTest
@testable import Le_Baluchon

class APIServiceTests: XCTestCase {
    let webServices: [WebService] = [.fixer, .googleTranslate, .yahooWeather]

    // MARK: - Test query handler failure

    func testQueryCompletionHandlerFailure() {
        for webservice in webServices {
            var input: String
            switch webservice {
            case .fixer: input = ""
            case .googleTranslate: input = "Hello World!"
            case .yahooWeather: input = "Paris"
            }

            testQueryShouldPostFailedCallbackIfError(webservice, input)
            testQueryShouldPostFailedCallbackIfNoData(webservice, input)
            testQueryShouldPostFailedCallbackIfIncorrectResponse(webservice, input)
        }
    }

    func testQueryShouldPostFailedCallbackIfError(_ webservice: WebService, _ input: String) {
        // Given
        let apiService = APIService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiService.query(API: webServices[0], input: input) { (success, resource) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(resource)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testQueryShouldPostFailedCallbackIfNoData(_ webservice: WebService, _ input: String) {
        // Given
        let apiService = APIService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiService.query(API: webServices[0], input: input) { (success, resource) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(resource)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

    func testQueryShouldPostFailedCallbackIfIncorrectResponse(_ webservice: WebService, _ input: String) {
        // Given
        let apiService = APIService(
            session: URLSessionFake(
                data: FakeResponseData.convertCorrectData,
                response: FakeResponseData.responseKO,
                error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiService.query(API: webServices[0], input: input) { (success, resource) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(resource)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

    // MARK: - Test Fixer callback

    func testQueryConvertShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let apiService = APIService(
            session: URLSessionFake(
                data: FakeResponseData.IncorrectData,
                response: FakeResponseData.responseOK,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiService.query(API: webServices[0]) { (success, resource) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(resource)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testQueryConvertShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let apiService = APIService(
            session: URLSessionFake(
                data: FakeResponseData.convertCorrectData,
                response: FakeResponseData.responseOK,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiService.query(API: webServices[0]) { (success, resource) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(resource)

            let rates = ["USD": 1.138064]
            XCTAssertEqual(rates["USD"], resource as? Double)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    // MARK: Test Google Translate callback

    func testQueryTranslateShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translateService = APIService(
            session: URLSessionFake(
                data: FakeResponseData.IncorrectData,
                response: FakeResponseData.responseOK,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.query(API: webServices[1], input: "Hello, World!") { (success, resource) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(resource)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testQueryTranslateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let translateService = APIService(
            session: URLSessionFake(
                data: FakeResponseData.translateCorrectData,
                response: FakeResponseData.responseOK,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.query(API: webServices[1], input: "Hello World!") { (success, resource) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(resource)

            let translatedText = "Bonjour Monde!"

            XCTAssertEqual(translatedText, resource as? String)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    // MARK: Test YahooWeather callback

    func testRequestShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = APIService(
            session: URLSessionFake(
                data: FakeResponseData.IncorrectData,
                response: FakeResponseData.responseOK,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.query(API: webServices[2], input: "Paris") { (success, resource) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(resource)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testRequestShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = APIService(
            session: URLSessionFake(
                data: FakeResponseData.weatherCorrectData,
                response: FakeResponseData.responseOK,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.query(API: webServices[2], input: "Paris") { (success, resource) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(resource as! Weather)

            let weatherCondition = resource as! Weather
            let city = "Paris"
            let code = "26"
            let temp = "5"

            XCTAssertEqual(city, weatherCondition.city)
            XCTAssertEqual(code, weatherCondition.code)
            XCTAssertEqual(temp, weatherCondition.temp)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
}
