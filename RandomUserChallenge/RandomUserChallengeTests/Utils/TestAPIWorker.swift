//
//  TestAPIWorker.swift
//  RandomUserChallengeTests
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

@testable import RandomUserChallenge

class TestAPIWorker: APIWorkerProtocol {
    var shouldFail = false
    var usersToRetrieve: [RandomUser] = []
    var fetchedPage = -1
    var fetchedResults = -1

    func fetch(page: Int, resultsPerPage: Int, onSuccess: @escaping ([RandomUser]) -> (), onError: @escaping (APIError?) -> Void) {
        fetchedPage = page
        fetchedResults = resultsPerPage

        if shouldFail {
            onError(nil)
        } else {
            onSuccess(usersToRetrieve)
        }
    }
}
