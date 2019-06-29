//
//  VIPConfigurator.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 29/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

protocol VIPConfigurable {
    func configureVIP()
}

extension VIPConfigurable where Self: RandomUserListViewController {
    func configureVIP() {
        let listPresenter = RandomUserListPresenter(presentable: self)
        let listRouter = RandomUserListRouter(viewController: self)
        let listInteractor = RandomUserListInteractor(
            resultsToLoad: 10,
            presenter: listPresenter,
            apiWorker: RandomUserAPIWorker(),
            dataPersistanceWorker: RandomUserPersistenceWorker(plistEditor: PlistEditor())
        )
        self.interactor = listInteractor
        self.router = listRouter
    }
}

extension VIPConfigurable where Self: RandomUserDetailViewController {
    func configureVIP() {
        let detailPresenter = RandomUserDetailPresenter(presentable: self)
        self.interactor = RandomUserDetailInteractor(presenter: detailPresenter)
    }
}
