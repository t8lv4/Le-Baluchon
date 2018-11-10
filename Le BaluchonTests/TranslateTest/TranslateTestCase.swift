//
//  TranslateTestCase.swift
//  Le BaluchonTests
//
//  Created by Morgan on 04/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import XCTest
@testable import Le_Baluchon

//class TranslateServiceTests: XCTestCase {
//
//    func testQueryShouldPostFailedCallbackIfError() {
//        // Given
//        let translateService = TranslateService(
//            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
//
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        translateService.query(to: GoogleTranslation.url, with: "Hello, World!") { (success, translatedText) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(translatedText)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testQueryShouldPostFailedCallbackIfNoData() {
//        // Given
//        let translateService = TranslateService(
//            session: URLSessionFake(data: nil, response: nil, error: nil))
//
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        translateService.query(to: GoogleTranslation.url, with: "Hello, World!") { (success, translatedText) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(translatedText)
//            expectation.fulfill()
//        }
//
//    wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testQueryShouldPostFailedCallbackIfIncorrectResponse() {
//        // Given
//        let translateService = TranslateService(
//            session: URLSessionFake(
//                data: FakeResponseData.convertCorrectData,
//                response: FakeResponseData.responseKO,
//                error: nil))
//        
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        translateService.query(to: GoogleTranslation.url, with: "Hello, World!") { (success, translatedText) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(translatedText)
//            expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testQueryShouldPostFailedCallbackIfIncorrectData() {
//        // Given
//        let translateService = TranslateService(
//            session: URLSessionFake(
//                data: FakeResponseData.IncorrectData,
//                response: FakeResponseData.responseOK,
//                error: nil))
//        
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        translateService.query(to: GoogleTranslation.url, with: "Hello, World!") { (success, translatedText) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(translatedText)
//            expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testQueryShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
//        // Given
//        let translateService = TranslateService(
//            session: URLSessionFake(
//                data: FakeResponseData.translateCorrectData,
//                response: FakeResponseData.responseOK,
//                error: nil))
//
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        translateService.query(to: GoogleTranslation.url, with: "Hello World!") { (success, translatedText) in
//            // Then
//            XCTAssertTrue(success)
//            XCTAssertNotNil(translatedText)
//
//            let translatedText = "Bonjour Monde!"
//
//            XCTAssertEqual(translatedText, translatedText)
//            // create as many asserts as constants
//
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//}
