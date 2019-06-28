//
//  RandomUserDetailViewController.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

class RandomUserDetailViewController: UIViewController, UIInstantiable, RandomUserDetailViewControllerProtocol {

    var randomUserData: RandomUser?
    var interactor: RandomUserDetailInteractorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let randomUser = randomUserData else {
            self.dismiss(animated: true, completion: nil) // TODO -> router
            return
        }

        setupUI(forUser: randomUser)
    }

    // MARK: - Private Interface

    private func setupUI(forUser user: RandomUser) {
        self.title = "\((user.name ?? "").capitalized) \((user.surname ?? "").capitalized)"
    }
}
