//
//  RandomUserListInteractor.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import Foundation

final class RandomUserListInteractor: RandomUserListInteractorProtocol {

    let presenter: RandomUserListPresenterProcotol
    let resultsPerPage: Int
    let randomUserApiWorker: APIWorkerProtocol

    // TODO: Add filter worker & persistence worker injection to improve testability
    init(resultsToLoad perPageResults: Int, presenter: RandomUserListPresenterProcotol, apiWorker: APIWorkerProtocol) {
        self.resultsPerPage = perPageResults
        self.presenter = presenter
        self.randomUserApiWorker = apiWorker
    }

    func doFetchRandomUsers(forPage nextPage: Int) {
        randomUserApiWorker.fetch(page: nextPage, resultsPerPage: resultsPerPage,
        onSuccess: { [weak self] (users) in
            self?.presenter.presentFetchRandomUsers(users, currentPage: nextPage, error: nil)
        },
        onError: { [weak self] error in
            self?.presenter.presentFetchRandomUsers([], currentPage: nextPage-1, error: error)
        })
    }

    func doFilterRandomUsers(_ users: [RandomUser], withFilter filter: RandomUserFilter) {
        let filteredUsers = RandomUserFilterWorker.filterRandomUsers(users, byFilter: filter)
        presenter.presentFilterRandomUsers(filteredUsers, appliedFilter: filter)
    }

    func doRemoveRandomUser(_ user: RandomUser, fromUsers: [RandomUser]) {
        // TODO
        presenter.presentRemoveRandomUser(user, updatedUsers: fromUsers, error: nil)
    }
}
