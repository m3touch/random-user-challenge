//
//  RandomUserDetailViewController.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

class RandomUserDetailViewController: UIViewController, UIInstantiable, RandomUserDetailViewControllerProtocol {

    private enum Constants {
        static let imagePlaceholder = UIImage(named: "user_placeholder")
    }

    var randomUserData: RandomUser?
    var interactor: RandomUserDetailInteractorProtocol?

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userGender: UILabel!
    @IBOutlet weak var userRegistrationDate: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userEmail: UILabel!

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

        userImage.setImage(fromURL: user.picture, placeholder: Constants.imagePlaceholder)
        userImage.layer.cornerRadius = userImage.bounds.height/2

        userGender.text = user.gender?.uppercased()
        userRegistrationDate.text = user.registeredDate
        userLocation.text = "\((user.location.street ?? "").capitalized), \((user.location.city ?? "").capitalized) (\((user.location.state ?? "").uppercased()))"
        userEmail.text = user.email ?? ""
    }
}
