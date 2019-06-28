//
//  Extensions+UIViewController.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

extension UIViewController {

    /**
     Shows a system alert inside the view controller. This alert will not be shown if the view is not
     in front in the views hierarchy.

     - parameters:
         - title: The title to show in the alert compnent. If non provided the text field will appear as so.
         - text: The body of the alert.
         - dismissButtonText: The text for the dismiss button.
     */
    func showAlertTiteled(_ title: String?, text: String, dismissButtonText: String) {
        guard self.view.window != nil else { return }

        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: dismissButtonText, style: .default)
        alert.addAction(dismissAction)

        self.present(alert, animated: true, completion: nil)
    }
}
