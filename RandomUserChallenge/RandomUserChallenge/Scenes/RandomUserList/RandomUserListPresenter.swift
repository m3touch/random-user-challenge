//
//  RandomUserListPresenter.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

final class RandomUserListPresenter: RandomUserListPresenterProcotol {

    weak var viewController: RandomUserListViewControllerProtocol?

    init(presentable viewController: RandomUserListViewControllerProtocol) {
        self.viewController = viewController
    }

    func presentFetchRandomUsers(_ newUsers: [RandomUser], currentPage: Int, error: APIError?) {
        // TODO
        viewController?.displayFetchRandomUsers(newUsers, currentPage: currentPage, error: nil)
    }

    func presentFilterRandomUsers(_ filteredUsers: [RandomUser], appliedFilter: RandomUserFilter) {
        // TODO
        viewController?.displayFilterRandomUsers(filteredUsers, appliedFilter: appliedFilter)
    }

    func presentRemoveRandomUser(_ removedUser: RandomUser?, updatedUsers: [RandomUser], error: Error?) {
        // TODO
        viewController?.displayRemoveRandomUser(
            removedUser,
            updatedRandomUsers: updatedUsers.count > 0 ? updatedUsers.dropLast() : [],
            error: nil
        )
    }
}
