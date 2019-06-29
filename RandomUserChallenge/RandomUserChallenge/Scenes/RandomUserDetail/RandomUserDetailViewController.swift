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

    var randomUser: RandomUser?
    var interactor: RandomUserDetailInteractorProtocol?

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userGender: UILabel!
    @IBOutlet weak var userRegistrationDate: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userEmail: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Private Interface

    private func setupUI() {
        self.title = "\((randomUser?.name ?? "-").capitalized) \((randomUser?.surname ?? "-").capitalized)"

        if let randomUserPicture = randomUser?.picture {
            userImage.setImage(fromURL: randomUserPicture, placeholder: Constants.imagePlaceholder)
        }
        userImage.layer.cornerRadius = userImage.bounds.height/2

        userGender.text = (randomUser?.gender ?? "-").uppercased()
        userRegistrationDate.text = randomUser?.registeredDate ?? ""
        userLocation.text = locationTextFrom(
            street: (randomUser?.location.street ?? "-").capitalized,
            city: (randomUser?.location.city ?? "-").capitalized,
            state: (randomUser?.location.state ?? "-").uppercased()
        )
        userEmail.text = randomUser?.email ?? "-"
    }

    private func locationTextFrom(street: String, city: String, state: String) -> String {
        return "\(street), \(city) (\(state))"
    }
}
