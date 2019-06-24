//
//  MainScreenViewModelStateTests.swift
//  ClearscoreTests
//
//  Created by Nuno Salvador on 23/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import XCTest

@testable import Clearscore

class MainScreenViewModelStateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIdleStatusAfterDidLoadEvent() {
        let asd = MainScreenViewModelState()
        asd.handleEvent(.didLoad(Credit(creditReportInfo: CreditReportInfo(score: 0, maximumScore: 0))))
        XCTAssertEqual(asd.state.status, MainScreenViewModelState.Status.idle)
    }
    
    func testFailedStatusAfterDidFailEvent() {
        let asd = MainScreenViewModelState()
        asd.handleEvent(.didFail(""))
        XCTAssertEqual(asd.state.status, MainScreenViewModelState.Status.failed(""))
    }
}
