//
//  RandomUserListRouter.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 29/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

final class RandomUserListRouter: RandomUserListRouterProcotol {

    weak var viewController: RandomUserListViewController?

    init(viewController: RandomUserListViewController) {
        self.viewController = viewController
    }

    func navigateToDetail(ofRandomUser userData: RandomUser) {
        let detailViewController = RandomUserDetailViewController.instiantate()
        let detailPresenter = RandomUserDetailPresenter(presentable: detailViewController)
        detailViewController.interactor = RandomUserDetailInteractor(presenter: detailPresenter)
        detailViewController.randomUserData = userData
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
