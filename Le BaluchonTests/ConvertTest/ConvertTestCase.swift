//
//  ConvertTestCase.swift
//  Le BaluchonTests
//
//  Created by Morgan on 04/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import XCTest
@testable import Le_Baluchon

class ConvertServiceTests: XCTestCase {
    func testGivenValue3Rate3ConvertShouldReturn1() {
        //given
        let value = 3.0
        let rate = 3.0
        //when
        let result = Convert.convert(value, with: rate)
        //then
        XCTAssertEqual(result, "1.00")
    }
}
