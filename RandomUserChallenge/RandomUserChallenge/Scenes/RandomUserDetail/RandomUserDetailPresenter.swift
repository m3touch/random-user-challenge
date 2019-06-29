//
//  RandomUserDetailPresenter.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

final class RandomUserDetailPresenter: RandomUserDetailPresenterProtocol {
    private weak var viewController: RandomUserDetailViewControllerProtocol?

    init(presentable viewController: RandomUserDetailViewControllerProtocol) {
        self.viewController = viewController
    }
}
