//
//  RandomUserPersistenceWorkerTests.swift
//  RandomUserChallengeTests
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import XCTest
@testable import RandomUserChallenge

class RandomUserPersistenceWorkerTests: XCTestCase {

    override func setUp() { }

    override func tearDown() { }

    func testRandomUserPersistenceWorker_deleteUser_storesTheUserIdentifier() {
        let testPlistEditor = TestPlistEditor()
        let persistenceWorker = RandomUserPersistenceWorker(plistEditor: testPlistEditor)

        persistenceWorker.deletePermanentlyRandomUser(RandomUserStub.firstUser)

        XCTAssert(testPlistEditor.savedIds.elementsEqual([RandomUserStub.firstUser.id.uuidString]))
    }

    func testRandomUserPersistenceWorker_deleteUser_removedFromAllUsersSequence() {
        let allUsersSequence = [RandomUserStub.firstUser, RandomUserStub.secondUser]
        let testPlistEditor = TestPlistEditor()
        let persistenceWorker = RandomUserPersistenceWorker(plistEditor: testPlistEditor)

        persistenceWorker.deletePermanentlyRandomUser(RandomUserStub.firstUser)
        let cleanedUpSequence = persistenceWorker.removeDeletedRandomUsersFrom(allUsersSequence)

        XCTAssert(cleanedUpSequence.elementsEqual([RandomUserStub.secondUser]))
    }
}
