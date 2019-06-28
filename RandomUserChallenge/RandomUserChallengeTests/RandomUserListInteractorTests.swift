//
//  RandomUserListInteractorTests.swift
//  RandomUserChallengeTests
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import XCTest
@testable import RandomUserChallenge

class RandomUserListInteractorTests: XCTestCase {

    override func setUp() { }

    override func tearDown() { }

    /*

     Fetches random users for the given page.

     After fetching the data, the results will be filtered to avoid duplicities and remove the permanently
     deleted random users.

     If an error occurs the resulting page should be the previous one to indicate the current page.

     */

    func testRandomUserListInteractor_configuredElementsPerPage_fetchesTheConfiguredElementsAmount() {
        let testPresenter = TestRandomUserListPresenter()
        let testAPIWorker = TestAPIWorker()
        let testDataPersistence = TestDataPersistance()
        let interactor = RandomUserListInteractor(
            resultsToLoad: 3,
            presenter: testPresenter,
            apiWorker: testAPIWorker,
            dataPersistanceWorker: testDataPersistence
        )

        interactor.doFetchRandomUsers([], forPage: 0)

        XCTAssertTrue(testAPIWorker.fetchedResults == 3)
    }

    func testRandomUserListInteractor_successFetching_filtersDuplicities() {
        let testPresenter = TestRandomUserListPresenter()
        let testAPIWorker = TestAPIWorker()
        testAPIWorker.usersToRetrieve = [RandomUserStub.firstUser, RandomUserStub.firstUser]
        let interactor = RandomUserListInteractor(
            resultsToLoad: 3,
            presenter: testPresenter,
            apiWorker: testAPIWorker,
            dataPersistanceWorker: RandomUserPersistenceWorker(plistEditor: TestPlistEditor())
        )

        interactor.doFetchRandomUsers([], forPage: 0)

        XCTAssertTrue(testPresenter.updatedUsers == [RandomUserStub.firstUser])
    }

    func testRandomUserListInteractor_successFetching_filtersDeletedUsers() {

        let testPresenter = TestRandomUserListPresenter()
        let testAPIWorker = TestAPIWorker()
        testAPIWorker.usersToRetrieve = [RandomUserStub.firstUser, RandomUserStub.secondUser]
        let testPlistEditor = TestPlistEditor()
        testPlistEditor.savedIds = [RandomUserStub.secondUser.id.uuidString]
        let interactor = RandomUserListInteractor(
            resultsToLoad: 3,
            presenter: testPresenter,
            apiWorker: testAPIWorker,
            dataPersistanceWorker: RandomUserPersistenceWorker(plistEditor: testPlistEditor)
        )

        interactor.doFetchRandomUsers([], forPage: 0)

        XCTAssertTrue(testPresenter.updatedUsers == [RandomUserStub.firstUser])
    }

    func testRandomUserListInteractor_errorFetching_updatesPagination() {

        let testPresenter = TestRandomUserListPresenter()
        let testAPIWorker = TestAPIWorker()
        testAPIWorker.shouldFail = true
        let testDataPersistence = TestDataPersistance()
        let interactor = RandomUserListInteractor(
            resultsToLoad: 3,
            presenter: testPresenter,
            apiWorker: testAPIWorker,
            dataPersistanceWorker: testDataPersistence
        )

        interactor.doFetchRandomUsers([], forPage: 3)

        XCTAssertTrue(testPresenter.currentPage == 2)
    }
}
