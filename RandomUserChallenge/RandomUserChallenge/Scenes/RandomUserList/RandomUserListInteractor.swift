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
    let dataPersistanceWorker: DataPersistanceProtocol

    init(resultsToLoad perPageResults: Int, presenter: RandomUserListPresenterProcotol, apiWorker: APIWorkerProtocol, dataPersistanceWorker: DataPersistanceProtocol) {
        self.resultsPerPage = perPageResults
        self.presenter = presenter
        self.randomUserApiWorker = apiWorker
        self.dataPersistanceWorker = dataPersistanceWorker
    }

    /**
     Fetches random users for the given page.

     After fetching the data, the results will be filtered to avoid duplicities and remove the permanently
     deleted random users.

     If an error occurs the resulting page should be the previous one to indicate the current page.

     - parameters:
         - currentUsers: The current users sequence to be updated with the new downloaded ones.
         - nextPage: The page to be fetched.
     */
    func doFetchRandomUsers(_ currentUsers: [RandomUser], forPage nextPage: Int) {
        randomUserApiWorker.fetch(
            page: nextPage,
            resultsPerPage: resultsPerPage,
            onSuccess: { [weak self] (users) in
                guard let saveSelf = self else { return }

                var totalUsers = currentUsers
                totalUsers.append(contentsOf: users)
                let totalUsersUnique = RandomUserFilterWorker.removeRepetitions(fromUsers: totalUsers)
                let updatedUsers = saveSelf.dataPersistanceWorker.removeDeletedRandomUsersFrom(totalUsersUnique)

                saveSelf.presenter.presentFetchRandomUsers(updatedUsers, currentPage: nextPage, error: nil)
            },
            onError: { [weak self] error in
                let previousPage = nextPage > 0 ? nextPage-1 : 0
                self?.presenter.presentFetchRandomUsers(currentUsers, currentPage: previousPage, error: error)
            }
        )
    }

    func doFilterRandomUsers(_ currentUsers: [RandomUser], withFilter filter: RandomUserFilter) {
        guard filter.searchValue != "" else {
            presenter.presentFilterRandomUsers(currentUsers, appliedFilter: filter)
            return
        }

        let filteredUsers = RandomUserFilterWorker.filterRandomUsers(currentUsers, byFilter: filter)
        presenter.presentFilterRandomUsers(filteredUsers, appliedFilter: filter)
    }

    func doRemoveRandomUser(_ user: RandomUser, fromUsers currentUsers: [RandomUser]) {
        dataPersistanceWorker.deletePermanentlyRandomUser(user)
        let updatedUsers = dataPersistanceWorker.removeDeletedRandomUsersFrom(currentUsers)

        presenter.presentRemoveRandomUser(user, updatedUsers: updatedUsers)
    }
}
