//
//  RandomUserCell.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

class RandomUserCell: UITableViewCell {

    private var indexPath: IndexPath?
    weak var delegate: RandomUserCellDelegate?

    @IBOutlet weak var userThumbnail: UIImageView!
    @IBOutlet weak var userNameAndSurname: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPhoneNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindWithRandomUser(name: String?, surname: String?, email: String?, phoneNumber: String?, indexPath: IndexPath) {
        self.indexPath = indexPath

        let userCompleteName = "\(name ?? "-") \(surname ?? "-")"
        userNameAndSurname.text = userCompleteName
        userEmail.text = email ?? "-"
        userPhoneNumber.text = "📞 \(phoneNumber ?? "")"
    }

    // MARK: - IB Actions

    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard
            let cellIndexPath = indexPath
        else {
            print("WARNING: User selected a cell without a known index path")
            return
        }
        delegate?.deleteButtonSelected(forRowAt: cellIndexPath)
    }
}
