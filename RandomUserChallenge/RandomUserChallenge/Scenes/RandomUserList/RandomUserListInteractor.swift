//
//  RandomUserListInteractor.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

final class RandomUserListInteractor: RandomUserListInteractorProtocol {

    let presenter: RandomUserListPresenterProcotol
    let resultsPerPage: Int

    init(resultsToLoad perPageResults: Int, presenter: RandomUserListPresenterProcotol) {
        self.resultsPerPage = perPageResults
        self.presenter = presenter
    }

    func doFetchRandomUsers(forPage nextPage: Int) {
        // TODO
    }

    func doFilterRandomUsers(_ users: [RandomUser], withFilter filter: RandomUserFilter) {
        // TODO
    }

    func doRemoveRandomUser(_ user: RandomUser) {
        // TODO
    }
}
