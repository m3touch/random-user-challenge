//
//  Extensions+UIImageView.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import AlamofireImage

extension UIImageView {
    /**
     Loads asynchronously (thread safe) the image from the provided URL, showing the placeholder
     image mean while.

     - parameters:
         - imageURL: An URL to load the image from.
         - placeholder: An UIImage to show while the image is being downloaded.
     */
    func setImage(fromURL imageURL: URL?, placeholder: UIImage?) {
        self.image = placeholder

        if let unwrappedImageURL = imageURL {
            self.af_setImage(withURL: unwrappedImageURL)
        }
    }
}
