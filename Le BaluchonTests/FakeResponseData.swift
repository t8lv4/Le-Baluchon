//
//  FakeResponseData.swift
//  Le BaluchonTests
//
//  Created by Morgan on 04/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

import Foundation

// MARK: - Data

/**
 Simulate a server response

 The structure follows (`data, response, error`) of the URLSession completion handler closure :
 cf in the model service file : `task = session.dataTask(with: request) { (data, response, error) in`.
 */
class FakeResponseData {
    /**
     Get valid data from a .json

     Create a variable per model's service to test
     */
    static var ConvertCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "fixer.json", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
}

// MARK: - HTTP status code

extension FakeResponseData {

    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!

}

// MARK: - Invalid data

extension FakeResponseData {

    static let IncorrectData = "erreur".data(using: .utf8)!

}

// MARK: - Error

extension FakeResponseData {

    class AnyError: Error {}
    static let error = AnyError()

}
