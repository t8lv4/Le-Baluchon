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

    let webService: WebService = .Fixer
    let input: String = "input"

func testQueryShouldPostFailedCallbackIfError() {
    // Given
    let apiService = APIService(
        session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
    
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change.")
    apiService.query(API: webService, input: input as AnyObject) { (success, resource) in
        // Then
        XCTAssertFalse(success)
        XCTAssertNil(resource)
        expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 0.01)
    }
    
    func testQueryShouldPostFailedCallbackIfNoData() {
        // Given
        let apiService = APIService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiService.query(API: webService, input: input as AnyObject) { (success, resource) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(resource)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    func testQueryShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let apiService = APIService(
            session: URLSessionFake(
                data: FakeResponseData.convertCorrectData,
                response: FakeResponseData.responseKO,
                error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiService.query(API: webService, input: input as AnyObject) { (success, resource) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(resource)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

//    func testQueryShouldPostFailedCallbackIfIncorrectData() {
//        // Given
//        let apiService = APIService(
//            session: URLSessionFake(
//                data: FakeResponseData.IncorrectData,
//                response: FakeResponseData.responseOK,
//                error: nil))
//
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        apiService.query(API: webService, input: input as AnyObject) { (success, resource) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(resource)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }

//    func testQueryShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
//        // Given
//        let apiService = APIService(
//            session: URLSessionFake(
//                data: FakeResponseData.convertCorrectData,
//                response: FakeResponseData.responseOK,
//                error: nil))
//
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        apiService.query(API: webService, input: input as AnyObject) { (success, resource) in
//            // Then
//            XCTAssertTrue(success)
//            XCTAssertNotNil(resource)
//
//            let rates = ["USD": 1.138064]
//
//            XCTAssertEqual(rates["USD"], resource as? Double)
//            // create as many asserts as constants
//
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }

}
