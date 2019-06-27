//
//  RandomUserListViewController.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

class RandomUserListViewController: UIViewController, UIInstantiable, RandomUserListViewControllerProtocol {

    var interactor: RandomUserListInteractorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func displayFetchRandomUsers(_ newUsers: [RandomUser], currentPage: Int, error: RandomUserListError?) {
        // TODO
    }

    func displayFilterRandomUsers(_ fileteredUsers: [RandomUser], appliedFilter: RandomUserFilter) {
        // TODO
    }

    func displayRemoveRandomUser(_ removedUser: RandomUser, updatedRandomUsers: [RandomUser], error: RandomUserListError?) {
        // TODO
    }
}
