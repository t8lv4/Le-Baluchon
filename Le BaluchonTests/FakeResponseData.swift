//
//  FakeResponseData.swift
//  Le BaluchonTests
//
//  Created by Morgan on 04/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

// MARK: - Data

/**
 Fake a server response

 The returned object is valid data from a .json file bundled in the application.
 - Note:
 Create a `myModelCorrectData` variable per model's service to test.
 */
class FakeResponseData {

    static var convertCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "fixer", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "googleTranslate", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "yahooWeather", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
}

// MARK: - HTTP status code

extension FakeResponseData {

    /// HTTP status code is 200
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    /// HTTP status code is 500
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!

}

// MARK: - Invalid data

extension FakeResponseData {

    static let IncorrectData = "erreur".data(using: .utf16)!

}

// MARK: - Error

extension FakeResponseData {

    class AnyError: Error {}
    static let error = AnyError()

}
