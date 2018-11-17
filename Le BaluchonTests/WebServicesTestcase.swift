//
//  WebServicesTestcase.swift
//  Le BaluchonTests
//
//  Created by Morgan on 17/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation
import XCTest
@testable import Le_Baluchon

class WebServicesTest: XCTestCase {

    func testInitYahooWeatherNotNil() {
        let forecast = YahooWeather(city: "Berlin")

        let city = forecast.place

        XCTAssertNotNil(city)
    }
}
