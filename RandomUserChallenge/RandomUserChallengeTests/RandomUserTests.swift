//
//  RandomUserTests.swift
//  RandomUserChallengeTests
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import XCTest
@testable import RandomUserChallenge

class RandomUserTests: XCTestCase {

    override func setUp() {}

    override func tearDown() {}

    func testRandomUserChallenge_invalidIdentifierUUID_throws() {
        let notUUIDString = "test"

        do {
            _ = try RandomUser(
                id: notUUIDString,
                name: nil,
                surname: nil,
                gender: nil,
                street: nil,
                city: nil,
                state: nil,
                phoneNumber: nil,
                email: nil,
                thumbnail: nil,
                picture: nil,
                registeredDate: nil
            )
            XCTFail()
        } catch RandomUserError.invalidUUID(wrongIdentifier: let badIdentifier){
            XCTAssertTrue(badIdentifier == notUUIDString)
        } catch {
            XCTFail()
        }
    }

    func testRandomUserChallenge_validIdentifierUUID_notThrows() {
        do {
            _ = try RandomUser(
                id: UUID().uuidString,
                name: nil,
                surname: nil,
                gender: nil,
                street: nil,
                city: nil,
                state: nil,
                phoneNumber: nil,
                email: nil,
                thumbnail: nil,
                picture: nil,
                registeredDate: nil
            )
        } catch RandomUserError.invalidUUID(wrongIdentifier: _){
            XCTFail()
        } catch {
            XCTFail()
        }
    }

    func testRandomUserChallenge_sameUserUUID_isEqual() {
        let validUUIDString = UUID().uuidString

        let firstUser = try! RandomUser(
            id: validUUIDString,
            name: nil,
            surname: nil,
            gender: nil,
            street: nil,
            city: nil,
            state: nil,
            phoneNumber: nil,
            email: nil,
            thumbnail: nil,
            picture: nil,
            registeredDate: nil
        )
        let secondUser = try! RandomUser(
            id: validUUIDString,
            name: nil,
            surname: nil,
            gender: nil,
            street: nil,
            city: nil,
            state: nil,
            phoneNumber: nil,
            email: nil,
            thumbnail: nil,
            picture: nil,
            registeredDate: nil
        )

        XCTAssertTrue(firstUser == secondUser)
    }

    func testRandomUserChallenge_differentUserUUID_isDifferent() {
        let firstUUIDString = UUID().uuidString
        let secondUUIDString = UUID().uuidString

        let firstUser = try! RandomUser(
            id: firstUUIDString,
            name: nil,
            surname: nil,
            gender: nil,
            street: nil,
            city: nil,
            state: nil,
            phoneNumber: nil,
            email: nil,
            thumbnail: nil,
            picture: nil,
            registeredDate: nil
        )
        let secondUser = try! RandomUser(
            id: secondUUIDString,
            name: nil,
            surname: nil,
            gender: nil,
            street: nil,
            city: nil,
            state: nil,
            phoneNumber: nil,
            email: nil,
            thumbnail: nil,
            picture: nil,
            registeredDate: nil
        )

        XCTAssertTrue(firstUser != secondUser)
    }
}
