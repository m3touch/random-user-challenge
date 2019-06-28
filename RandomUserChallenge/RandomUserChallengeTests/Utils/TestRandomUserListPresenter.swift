//
//  TestRandomUserListPresenter.swift
//  RandomUserChallengeTests
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

@testable import RandomUserChallenge

class TestRandomUserListPresenter: RandomUserListPresenterProcotol {
    var currentPage = -1
    var updatedUsers: [RandomUser] = []

    func presentFetchRandomUsers(_ updatedUsers: [RandomUser], currentPage: Int, error: APIError?) {
        self.updatedUsers = updatedUsers
        self.currentPage = currentPage
    }

    func presentFilterRandomUsers(_ filteredUsers: [RandomUser], appliedFilter: RandomUserFilter) {
        self.updatedUsers = filteredUsers
    }

    func presentRemoveRandomUser(_ removedUser: RandomUser, updatedUsers: [RandomUser]) {
        self.updatedUsers = updatedUsers
    }
}
