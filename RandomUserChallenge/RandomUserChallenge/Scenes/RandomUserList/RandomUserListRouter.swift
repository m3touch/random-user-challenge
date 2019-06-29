//
//  RandomUserListRouter.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 29/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

final class RandomUserListRouter: RandomUserListRouterProcotol {

    weak var viewController: RandomUserListViewControllerProtocol?

    init(viewController: RandomUserListViewControllerProtocol) {
        self.viewController = viewController
    }

    func navigateToDetail(ofRandomUser userData: RandomUser) {
        let detailViewController = RandomUserDetailViewController.instiantate()
        detailViewController.configureVIP()
        detailViewController.randomUser = userData

        if let viewController = viewController as? UIViewController {
            viewController.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
