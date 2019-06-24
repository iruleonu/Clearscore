//
//  MainScreenViewModelTests.swift
//  ClearscoreTests
//
//  Created by Nuno Salvador on 23/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import XCTest
import Combine

@testable import Clearscore

class MainScreenViewModelTests: XCTestCase {
    var subject: MainScreenViewModelImpl!
    
    override func setUp() {
        super.setUp()
        let routing = MainScreenRoutingMock()
        let network = NetworkMock()
        subject = MainScreenViewModelImpl(routing: routing, network: network)
    }

    override func tearDown() {
        super.tearDown()
        subject = nil
    }
    
    func testIdleStatusAfterDidLoadEvent() {
        let vmState = MainScreenViewModelState()
        vmState.handleEvent(.didLoad(Credit(creditReportInfo: CreditReportInfo(score: 0, maximumScore: 0))))
        XCTAssertEqual(vmState.state.status, MainScreenViewModelState.Status.idle)
    }
    
    func testDoughtnutProgressReturnsAValidValueWhenGreaterThenOne() {
        let credit = Credit(creditReportInfo: CreditReportInfo(score: 5, maximumScore: 1))
        let progress = MainScreenViewModelImpl.calculateDoughtnutProgress(forCredit: credit)
        XCTAssertTrue(progress <= 1.0)
    }
    
    func testDoughtnutProgressReturnsAValidValueWhenLessThanOne() {
        let credit = Credit(creditReportInfo: CreditReportInfo(score: 1, maximumScore: -5))
        let progress = MainScreenViewModelImpl.calculateDoughtnutProgress(forCredit: credit)
        XCTAssertTrue(progress >= 0.0)
    }
    
    func testScoreTextContainsScore() {
        let credit = Credit(creditReportInfo: CreditReportInfo(score: 1, maximumScore: -5))
        let scoreText = MainScreenViewModelImpl.getScoreText(forCredit: credit)
        XCTAssertTrue(scoreText.contains("\(credit.creditReportInfo.score)"))
    }
    
    func testMaximumScoreTextContainsMaximumScore() {
        let credit = Credit(creditReportInfo: CreditReportInfo(score: 1, maximumScore: -5))
        let maximumScoreText = MainScreenViewModelImpl.getMaximumScoreText(forCredit: credit)
        XCTAssertTrue(maximumScoreText.contains("\(credit.creditReportInfo.maximumScore)"))
    }
    
    func testViewDidLoadCallsFetchCreditAndStateUpdated() {
        let expectation = self.expectation(description: "Calls fetch credit and state updated after onDidLoad")
        
        _ = subject.outputs.vmStateUpdated.sink(receiveValue: { state in
            expectation.fulfill()
        })
        subject.inputs.onDidLoad()
        
        waitForExpectations(timeout: TimeInterval(1)) { error in
            if error != nil {
                XCTFail()
            }
        }
    }
}

private class MainScreenRoutingMock: MainScreenRouting {
    
}

private class NetworkMock: APIFetchScoreProtocol {
    func fetchCredit() -> AnyPublisher<Credit, APIServiceError> {
        return Publishers.Empty().eraseToAnyPublisher()
    }
}
