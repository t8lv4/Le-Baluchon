//
//  ConvertTestCase.swift
//  Le BaluchonTests
//
//  Created by Morgan on 04/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

//override func setUp() {
//    // Put setup code here. This method is called before the invocation of each test method in the class.
//}
//
//override func tearDown() {
//    // Put teardown code here. This method is called after the invocation of each test method in the class.
//}

import XCTest
@testable import Le_Baluchon

class ConvertServiceTests: XCTestCase {

    func testQueryShouldPostFailedCallbackIfError() {
        // Given
        let convertService = ConvertService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        convertService.query(to: Fixer.url) { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testQueryShouldPostFailedCallbackIfNoData() {
        // Given
        let convertService = ConvertService(
            session: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        convertService.query(to: Fixer.url) { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testQueryShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let convertService = ConvertService(
            session: URLSessionFake(
                data: FakeResponseData.convertCorrectData,
                response: FakeResponseData.responseKO,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        convertService.query(to: Fixer.url) { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testQueryShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let convertService = ConvertService(
            session: URLSessionFake(
                data: FakeResponseData.IncorrectData,
                response: FakeResponseData.responseOK,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        convertService.query(to: Fixer.url) { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testQueryShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let convertService = ConvertService(
            session: URLSessionFake(
                data: FakeResponseData.convertCorrectData,
                response: FakeResponseData.responseOK,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        convertService.query(to: Fixer.url) { (success, rate) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(rate)

            let rates = ["USD": 1.138064]

            XCTAssertEqual(rates["USD"], rate)
            // create as many asserts as constants

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
}

// test currency conversion
extension ConvertServiceTests {

    func testValue3Rate3ConvertShouldReturn1() {
        //given
        let value = 3.0
        let rate = 3.0
        //when
        let result = Convert.convert(value, with: rate)
        //then
        XCTAssertEqual(result, "1.00")
    }
    
}
