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

    init(resultsToLoad perPageResults: Int, presenter: RandomUserListPresenterProcotol) {
        self.resultsPerPage = perPageResults
        self.presenter = presenter
    }

    func doFetchRandomUsers(forPage nextPage: Int) {
        // TODO
        presenter.presentFetchRandomUsers(getStubbedUsers(), currentPage: nextPage, error: nil)
    }

    func doFilterRandomUsers(_ users: [RandomUser], withFilter filter: RandomUserFilter) {
        let filteredUsers = RandomUserFilterWorker.filterRandomUsers(users, byFilter: filter)
        presenter.presentFilterRandomUsers(filteredUsers, appliedFilter: filter)
    }

    func doRemoveRandomUser(_ user: RandomUser, fromUsers: [RandomUser]) {
        // TODO
        presenter.presentRemoveRandomUser(user, updatedUsers: fromUsers, error: nil)
    }

    private func getStubbedUsers() -> [RandomUser] {
        return [
            //swiftlint:disable:next force_try
            try! RandomUser(
                id: UUID().uuidString,
                name: "FirstUser",
                surname: "FirstSurname",
                gender: "male",
                street: "Street 1",
                city: "City 1",
                state: "State 1",
                phoneNumber: "+34 111",
                email: "111@111.com",
                thumbnail: "https://react.semantic-ui.com/images/avatar/large/molly.png",
                picture: "https://react.semantic-ui.com/images/avatar/large/molly.png",
                registeredDate: "11:11:11 11/11/11"
            ),
            //swiftlint:disable:next force_try
            try! RandomUser(
                id: UUID().uuidString,
                name: "SecondUser",
                surname: "SecondSurname",
                gender: "female",
                street: "Street 2",
                city: "City 2",
                state: "State 2",
                phoneNumber: "+34 222",
                email: "222@222.com",
                thumbnail: "https://semantic-ui.com/images/avatar2/large/kristy.png",
                picture: "https://semantic-ui.com/images/avatar2/large/kristy.png",
                registeredDate: "22:22:22 22/22/22"
            ),
            //swiftlint:disable:next force_try
            try! RandomUser(
                id: UUID().uuidString,
                name: "ThirdUser",
                surname: "ThirdSurname",
                gender: "male",
                street: "Street 3",
                city: "City 3",
                state: "State 3",
                phoneNumber: "+34 333",
                email: "333@333.com",
                thumbnail: "https://semantic-ui.com/images/avatar2/large/mark.png",
                picture: "https://semantic-ui.com/images/avatar2/large/mark.png",
                registeredDate: "33:33:33 33/33/33"
            )
        ]
    }
}
