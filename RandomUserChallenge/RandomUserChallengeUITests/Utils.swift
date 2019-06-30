//
//  Utils.swift
//  RandomUserChallengeUITests
//
//  Created by Marta Tarragó on 30/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import XCTest
@testable import RandomUserChallenge

enum Predicate {
    static let existance: NSPredicate = NSPredicate(format: "exists == true")
}

enum WaitTime {
    static let existance: Double = 30
}

extension XCTestCase {
    func waitToAppear(_ component: XCUIElement, errorMessage errSms: String) {
        expectation(for: Predicate.existance, evaluatedWith: component, handler: nil)
        waitForExpectations(timeout: WaitTime.existance) { (err) in
            guard err == nil else {
                XCTFail(errSms)
                return
            }
        }
    }
}
