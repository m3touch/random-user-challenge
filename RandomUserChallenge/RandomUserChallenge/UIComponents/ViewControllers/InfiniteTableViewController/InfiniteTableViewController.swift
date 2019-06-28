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

        if loadedTheLastRowCell(currentIndexPath: indexPath) {
            delegate?.loadMoreData()
        }

        cell.bindWithRandomUserAt(
            indexPath: indexPath,
            name: userData.name,
            surname: userData.surname,
            email: userData.email,
            phoneNumber: userData.phoneNumber,
            thumbnail: userData.thumbnail
        )

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        delegate?.deleteUserAtRow(indexPath: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegate?.selectedCellAt(indexPath: indexPath)
    }

    // MARK: - Private interface

    private func prepareTableView() {
        let randomUserCellNib = UINib(nibName: Constants.cellIdentifier, bundle: nil)
        tableView.register(randomUserCellNib, forCellReuseIdentifier: Constants.cellIdentifier)
    }

    private func loadedTheLastRowCell(currentIndexPath: IndexPath) -> Bool {
        return currentIndexPath.row == tableView.numberOfRows(inSection: 0)-1
    }
}
