//
//  RandomUserCell.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

class RandomUserCell: UITableViewCell {

    enum Constants {
        static let placeholderImage = UIImage(named: "user_placeholder")
    }

    private var indexPath: IndexPath?

    @IBOutlet weak var userThumbnail: UIImageView!
    @IBOutlet weak var userNameAndSurname: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPhoneNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindWithRandomUserAt(indexPath: IndexPath, name: String?, surname: String?, email: String?, phoneNumber: String?, thumbnail: URL?) {
        self.indexPath = indexPath

        let userCompleteName = "\(name ?? "-") \(surname ?? "-")"
        userNameAndSurname.text = userCompleteName
        userEmail.text = email ?? "-"
        userPhoneNumber.text = "📞 \(phoneNumber ?? "")"
        userThumbnail.setImage(
            fromURL: thumbnail,
            placeholder: Constants.placeholderImage
        )
    }
}
