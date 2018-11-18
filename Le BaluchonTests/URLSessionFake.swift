//
//  URLSessionFake.swift
//  Le BaluchonTests
//
//  Created by Morgan on 04/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/**
 Simulate a server response,
 double URLSession to adress dataTask(with url:...)
 and dataTask(with request:...) tests

 The structure follows (`data, response, error`) of the URLSession completion handler closure (
 cf in the API service file : `task = session.dataTask(with: request) { (data, response, error) in`).
 */
class URLSessionFake: URLSession {
    //completion handler properties
    var data: Data?
    var response: URLResponse?
    var error: Error?

    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
}

extension URLSessionFake {
    override func dataTask(with url: URL, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }
}


/// double URLSessionDataTask to adress resume() and cancel() tests
class URLSessionDataTaskFake: URLSessionDataTask {
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?

    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }

    override func cancel() {}
}

