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
    }

    func presentFilterRandomUsers(_ filteredUsers: [RandomUser], appliedFilter: RandomUserFilter) {
        // TODO
    }

    func presentRemoveRandomUser(_ removedUser: RandomUser?, error: Error?) {
        // TODO
    }
}
