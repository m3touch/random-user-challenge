//
//  UIViewController+Extensions.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(titled: String, text: String, dismissButtonText: String) {
        let alert = UIAlertController(title: titled, message: text, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: dismissButtonText, style: .default)
        alert.addAction(dismissAction)

        self.present(alert, animated: true, completion: nil)
    }
}
