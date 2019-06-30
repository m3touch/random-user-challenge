//
//  RandomUserFilterWorkerTest.swift
//  RandomUserChallengeTests
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import XCTest
@testable import RandomUserChallenge

class RandomUserFilterWorkerTest: XCTestCase {

    override func setUp() { }

    override func tearDown() { }

    // MARK: - Filter

    func testRandomUserFilterWorker_filterWithNoNameMatch_returnsEmptySequence() {
        let randomUsers = [RandomUserStub.firstUser, RandomUserStub.secondUser]
        let nameFilter = RandomUserFilter(category: .name, searchValue: "Test")

        let filteredRandomUsers = RandomUserFilterWorker.filterRandomUsers(randomUsers, byFilter: nameFilter)

        XCTAssertTrue(filteredRandomUsers.count == 0)
    }

    func testRandomUserFilterWorker_filterWithNameMatch_returnsFilteredSequence() {
        let randomUsers = [RandomUserStub.firstUser, RandomUserStub.secondUser]
        let nameFilter = RandomUserFilter(category: .name, searchValue: "First")

        let filteredRandomUsers = RandomUserFilterWorker.filterRandomUsers(randomUsers, byFilter: nameFilter)

        XCTAssertTrue(filteredRandomUsers.count == 1)
        XCTAssertTrue(filteredRandomUsers.elementsEqual([RandomUserStub.firstUser]))
    }

    func testRandomUserFilterWorker_filterWithNoSurnameMatch_returnsEmptySequence() {
        let randomUsers = [RandomUserStub.firstUser, RandomUserStub.secondUser]
        let surnameFilter = RandomUserFilter(category: .surname, searchValue: "Test")

        let filteredRandomUsers = RandomUserFilterWorker.filterRandomUsers(randomUsers, byFilter: surnameFilter)

        XCTAssertTrue(filteredRandomUsers.count == 0)
    }

    func testRandomUserFilterWorker_filterWithNoEmailMatch_returnsEmptySequence() {
        let randomUsers = [RandomUserStub.firstUser, RandomUserStub.secondUser]
        let surnameFilter = RandomUserFilter(category: .surname, searchValue: "First")

        let filteredRandomUsers = RandomUserFilterWorker.filterRandomUsers(randomUsers, byFilter: surnameFilter)

        XCTAssertTrue(filteredRandomUsers.count == 1)
        XCTAssertTrue(filteredRandomUsers.elementsEqual([RandomUserStub.firstUser]))
    }

    func testRandomUserFilterWorker_filterWithSurnameMatch_returnsFilteredSequence() {
        let randomUsers = [RandomUserStub.firstUser, RandomUserStub.secondUser]
        let emailFilter = RandomUserFilter(category: .email, searchValue: "Test")

        let filteredRandomUsers = RandomUserFilterWorker.filterRandomUsers(randomUsers, byFilter: emailFilter)

        XCTAssertTrue(filteredRandomUsers.count == 0)
    }

    func testRandomUserFilterWorker_filterWithEmailMatch_returnsFilteredSequence() {
        let randomUsers = [RandomUserStub.firstUser, RandomUserStub.secondUser]
        let emailFilter = RandomUserFilter(category: .email, searchValue: "111")

        let filteredRandomUsers = RandomUserFilterWorker.filterRandomUsers(randomUsers, byFilter: emailFilter)

        XCTAssertTrue(filteredRandomUsers.count == 1)
        XCTAssertTrue(filteredRandomUsers.elementsEqual([RandomUserStub.firstUser]))
    }

    // MARK: - Duplicates

    func testRandomUserFilterWorker_filterDuplicatesWithoutRepetition_returnsSameSequence() {
        let randomUsers = [RandomUserStub.firstUser, RandomUserStub.secondUser]

        let filteredRandomUsers = RandomUserFilterWorker.removeRepetitions(fromUsers: randomUsers)

        XCTAssertTrue(randomUsers.elementsEqual(filteredRandomUsers))
    }

    func testRandomUserFilterWorker_filterDuplicatesWithRepetition_returnsClearedSequence() {
        let randomUsers = [RandomUserStub.firstUser, RandomUserStub.secondUser, RandomUserStub.firstUser]
        let withoutDuplicationUsers = [RandomUserStub.firstUser, RandomUserStub.secondUser]

        let filteredRandomUsers = RandomUserFilterWorker.removeRepetitions(fromUsers: randomUsers)

        XCTAssertTrue(filteredRandomUsers.count == randomUsers.count-1)
        XCTAssertTrue(filteredRandomUsers.elementsEqual(withoutDuplicationUsers))
    }

    // MARK: - Remove

    func testRandomUserFilterWorker_removeWithNotFoundRandomUserIds_returnsSameSequence() {
        let randomUsers = [RandomUserStub.firstUser, RandomUserStub.secondUser]
        let uuidsToRemove = [UUID(uuidString: "11111111-7D62-40B6-9F13-9FD8C27B2FE3")!]

        let filteredRandomUsers = RandomUserFilterWorker.removeUnwantedUsers(uuidsToRemove, fromUsers: randomUsers)

        XCTAssertTrue(filteredRandomUsers.elementsEqual(randomUsers))
    }

    func testRandomUserFilterWorker_removeWithFoundRandomUserIds_returnsFilteredSequence() {
        let randomUsers = [RandomUserStub.firstUser, RandomUserStub.secondUser]
        let uuidsToRemove = [RandomUserStub.firstUser.id]

        let filteredRandomUsers = RandomUserFilterWorker.removeUnwantedUsers(uuidsToRemove, fromUsers: randomUsers)

        XCTAssertTrue(filteredRandomUsers.elementsEqual([RandomUserStub.secondUser]))
    }
}
