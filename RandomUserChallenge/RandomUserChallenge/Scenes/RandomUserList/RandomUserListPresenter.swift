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

    func presentFetchRandomUsers(_ updatedUsers: [RandomUser], currentPage: Int, error: APIError?) {
        viewController?.displayFetchRandomUsers(
            updatedUsers,
            currentPage: currentPage,
            error: assemble(apiError: error)
        )
    }

    func presentFilterRandomUsers(_ filteredUsers: [RandomUser], appliedFilter: RandomUserFilter) {
        viewController?.displayFilterRandomUsers(filteredUsers, appliedFilter: appliedFilter)
    }

    func presentRemoveRandomUser(_ removedUser: RandomUser, updatedUsers: [RandomUser]) {
        viewController?.displayRemoveRandomUser(
            removedUser,
            updatedUsers: updatedUsers
        )
    }

    // MARK: - Private Interface

    private func assemble(apiError: APIError?) -> RandomUserListError? {
        guard let error = apiError else { return nil }

        switch error {
        case .serviceCallFailed:
            return .unableToLoadUsers(userMessage: "Ups! We couldn't connect with the server to load users.")
        case .unexpectedServiceAnswerFormat, .unableToBuildCall:
            return .unableToLoadUsers(userMessage: nil)
        }
    }
}
