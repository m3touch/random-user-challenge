//
//  InfiniteTableViewController.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

class InfiniteTableViewController: UITableViewController {

    enum Constants {
        static let cellIdentifier = String(describing: RandomUserCell.self)
        static let rowHeight: CGFloat = 100
    }

    weak var delegate: InfiniteTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareTableView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.infiniteTableViewDataSource.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let userData = delegate?.getCellDataForRowAt(indexPath: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? RandomUserCell
        else {
            return UITableViewCell()
        }

        cell.delegate = delegate as? RandomUserCellDelegate
        cell.bindWithRandomUser(
            name: userData.name,
            surname: userData.surname,
            email: userData.email,
            phoneNumber: userData.phoneNumber,
            indexPath: indexPath
        )

        return cell
    }

    // MARK: - Private interface

    private func prepareTableView() {
        let randomUserCellNib = UINib(nibName: Constants.cellIdentifier, bundle: nil)
        tableView.register(randomUserCellNib, forCellReuseIdentifier: Constants.cellIdentifier)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
}
