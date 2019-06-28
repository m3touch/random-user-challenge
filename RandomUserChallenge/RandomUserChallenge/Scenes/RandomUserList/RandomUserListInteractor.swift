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

    func doFetchRandomUsers(_ currentUsers: [RandomUser], forPage nextPage: Int) {
        randomUserApiWorker.fetch(
            page: nextPage,
            resultsPerPage: resultsPerPage,
            onSuccess: { [weak self] (users) in
                var totalUsers = currentUsers
                totalUsers.append(contentsOf: users)
                let totalUsersUnique = RandomUserFilterWorker.removeRepetitions(fromUsers: totalUsers)
                self?.presenter.presentFetchRandomUsers(totalUsersUnique, currentPage: nextPage, error: nil)
            },
            onError: { [weak self] error in
                let previousPage = nextPage > 0 ? nextPage-1 : 0
                self?.presenter.presentFetchRandomUsers(currentUsers, currentPage: previousPage, error: error)
            }
        )
    }

    func doFilterRandomUsers(_ currentUsers: [RandomUser], withFilter filter: RandomUserFilter) {
        let filteredUsers = RandomUserFilterWorker.filterRandomUsers(currentUsers, byFilter: filter)
        presenter.presentFilterRandomUsers(filteredUsers, appliedFilter: filter)
    }

    func doRemoveRandomUser(_ user: RandomUser, fromUsers currentUsers: [RandomUser]) {
        // TODO
        presenter.presentRemoveRandomUser(user, updatedUsers: currentUsers, error: nil)
    }
}
