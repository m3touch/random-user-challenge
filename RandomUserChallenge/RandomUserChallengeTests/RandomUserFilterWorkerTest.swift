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
        let randomUsers = randomUsersStub
        let nameFilter = RandomUserFilter(category: .name, searchValue: "Test")

        let filteredRandomUsers = RandomUserFilterWorker.filterRandomUsers(randomUsers, byFilter: nameFilter)

        XCTAssertTrue(filteredRandomUsers.count == 0)
    }

    func testRandomUserFilterWorker_filterWithNameMatch_returnsFilteredSequence() {
        let randomUsers = randomUsersStub
        let nameFilter = RandomUserFilter(category: .name, searchValue: "First")

        let filteredRandomUsers = RandomUserFilterWorker.filterRandomUsers(randomUsers, byFilter: nameFilter)

        XCTAssertTrue(filteredRandomUsers.count == 1)
        XCTAssertTrue(filteredRandomUsers.elementsEqual([firstUser]))
    }

    func testRandomUserFilterWorker_filterWithNoSurnameMatch_returnsEmptySequence() {
        let randomUsers = randomUsersStub
        let surnameFilter = RandomUserFilter(category: .surname, searchValue: "Test")

        let filteredRandomUsers = RandomUserFilterWorker.filterRandomUsers(randomUsers, byFilter: surnameFilter)

        XCTAssertTrue(filteredRandomUsers.count == 0)
    }

    func testRandomUserFilterWorker_filterWithNoEmailMatch_returnsEmptySequence() {
        let randomUsers = randomUsersStub
        let surnameFilter = RandomUserFilter(category: .surname, searchValue: "First")

        let filteredRandomUsers = RandomUserFilterWorker.filterRandomUsers(randomUsers, byFilter: surnameFilter)

        XCTAssertTrue(filteredRandomUsers.count == 1)
        XCTAssertTrue(filteredRandomUsers.elementsEqual([firstUser]))
    }

    func testRandomUserFilterWorker_filterWithSurnameMatch_returnsFilteredSequence() {
        let randomUsers = randomUsersStub
        let emailFilter = RandomUserFilter(category: .email, searchValue: "Test")

        let filteredRandomUsers = RandomUserFilterWorker.filterRandomUsers(randomUsers, byFilter: emailFilter)

        XCTAssertTrue(filteredRandomUsers.count == 0)
    }

    func testRandomUserFilterWorker_filterWithEmailMatch_returnsFilteredSequence() {
        let randomUsers = randomUsersStub
        let emailFilter = RandomUserFilter(category: .email, searchValue: "111")

        let filteredRandomUsers = RandomUserFilterWorker.filterRandomUsers(randomUsers, byFilter: emailFilter)

        XCTAssertTrue(filteredRandomUsers.count == 1)
        XCTAssertTrue(filteredRandomUsers.elementsEqual([firstUser]))
    }

    // MARK: - Remove

    // elimina be uuids
    // si no troba match retorna el mateix array al eliminar uuids

    func testRandomUserFilterWorker_removeWithNotFoundRandomUserIds_returnsSameSequence() {
        let randomUsers = randomUsersStub
        let uuidsToRemove = [UUID(uuidString: "11111111-7D62-40B6-9F13-9FD8C27B2FE3")!]

        let filteredRandomUsers = RandomUserFilterWorker.removeUnwantedUsers(uuidsToRemove, fromUsers: randomUsers)

        XCTAssertTrue(filteredRandomUsers.elementsEqual(randomUsers))
    }

    func testRandomUserFilterWorker_removeWithFoundRandomUserIds_returnsFilteredSequence() {
        let randomUsers = randomUsersStub
        let uuidsToRemove = [firstUser.id]

        let filteredRandomUsers = RandomUserFilterWorker.removeUnwantedUsers(uuidsToRemove, fromUsers: randomUsers)

        XCTAssertTrue(filteredRandomUsers.elementsEqual([secondUser]))
    }
}

extension RandomUserFilterWorkerTest {
    var firstUser: RandomUser {
        //swiftlint:disable:next force_try
        return try! RandomUser(
            id: "0FDA2BD6-7D62-40B6-9F13-9FD8C27B2FE3",
            name: "FirstUser",
            surname: "FirstSurname",
            gender: "male",
            street: "Street 1",
            city: "City 1",
            state: "State 1",
            phoneNumber: "+34 111",
            email: "111@111.com",
            thumbnail: "https://react.semantic-ui.com/images/avatar/large/molly.png",
            picture: "https://react.semantic-ui.com/images/avatar/large/molly.png",
            registeredDate: "11:11:11 11/11/11"
        )
    }

    var secondUser: RandomUser {
        //swiftlint:disable:next force_try
        return try! RandomUser(
            id: "6F412147-FA07-4724-94C0-2EFFFFAA7EEC",
            name: "SecondUser",
            surname: "SecondSurname",
            gender: "female",
            street: "Street 2",
            city: "City 2",
            state: "State 2",
            phoneNumber: "+34 222",
            email: "222@222.com",
            thumbnail: "https://semantic-ui.com/images/avatar2/large/kristy.png",
            picture: "https://semantic-ui.com/images/avatar2/large/kristy.png",
            registeredDate: "22:22:22 22/22/22"
        )
    }

    var randomUsersStub: [RandomUser] {
        return [firstUser, secondUser]
    }
}
