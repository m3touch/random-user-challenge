//
//  RandomUserListViewController.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

class RandomUserListViewController: UIViewController, UIInstantiable, RandomUserListViewControllerProtocol {

    // MARK: - Properties

    enum Constants {
        static let cellIdentifier = String(describing: RandomUserCell.self)
        static let rowHeight: CGFloat = 100
    }

    var interactor: RandomUserListInteractorProtocol?

    private var currentPage = 0
    fileprivate var randomUsers: [RandomUser] = []
    fileprivate var filteredRandomUsers: [RandomUser] = []
    fileprivate var isFilteringUsers: Bool {
        return filteredRandomUsers.count != 0
    }

    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        interactor?.doFetchRandomUsers(forPage: currentPage+1)
    }

    // MARK: - RandomUserListViewControllerProtocol Protocol Impelementation

    func displayFetchRandomUsers(_ newUsers: [RandomUser], currentPage: Int, error: RandomUserListError?) {
        guard error == nil else { return } // TODO -> Manage the errors after fetching users

        randomUsers.append(contentsOf: newUsers)
        self.currentPage = currentPage
        reloadUsersTableView()
    }

    func displayFilterRandomUsers(_ fileteredUsers: [RandomUser], appliedFilter: RandomUserFilter) {
        filteredRandomUsers = fileteredUsers
        reloadUsersTableView()
    }

    func displayRemoveRandomUser(_ removedUser: RandomUser?, updatedRandomUsers: [RandomUser], error: RandomUserListError?) {
        // TODO --> MANAGE ERROR REMOVING USER
        guard let removedUserData = removedUser else { return }

        randomUsers = updatedRandomUsers
        reloadUsersTableView()
        showRemovedUserAlert(userData: removedUserData)
    }

    // MARK: - Private Interface

    private func setupUI() {
        prepareTableView()
        showEmptyScreen()
    }

    private func showEmptyScreen() {
        // TODO: Customize the message for the given filter?
        usersTableView.isHidden = true
    }

    private func hideEmptyScreen() {
        usersTableView.isHidden = false
    }

    fileprivate func userData(forIndex dataIndex: IndexPath) -> RandomUser? {
        if isFilteringUsers && filteredRandomUsers.count > dataIndex.row {
            return filteredRandomUsers[dataIndex.row]
        }

        if !isFilteringUsers && randomUsers.count > dataIndex.row {
            return randomUsers[dataIndex.row]
        }

        return nil
    }

    fileprivate func showRemovedUserAlert(userData: RandomUser) {
        let alertTitle = "Removed User"
        let alertMessage = "\(userData.name ?? "-") \(userData.surname ?? "-"), with identifier: \(userData.id.uuidString), has been removed permanently."
        let alertDismissText = "Ok"

        showAlert(
            titled: alertTitle,
            text: alertMessage,
            dismissButtonText: alertDismissText
        )
    }
}

extension RandomUserListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFilteringUsers ? filteredRandomUsers.count : randomUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let userData = userData(forIndex: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? RandomUserCell
        else {
            return UITableViewCell()
        }

        cell.delegate = self
        cell.bindWithRandomUser(
            name: userData.name,
            surname: userData.surname,
            email: userData.email,
            phoneNumber: userData.phoneNumber,
            indexPath: indexPath
        )

        return cell
    }

    fileprivate func prepareTableView() {
        let randomUserCellNib = UINib(nibName: Constants.cellIdentifier, bundle: nil)
        usersTableView.register(randomUserCellNib, forCellReuseIdentifier: Constants.cellIdentifier)
    }

    fileprivate func reloadUsersTableView() {
        let dataSource = isFilteringUsers ? filteredRandomUsers : randomUsers
        if dataSource.count != 0 {
            hideEmptyScreen()
            usersTableView.reloadData()
        } else {
            showEmptyScreen()
        }
    }
}

extension RandomUserListViewController: RandomUserCellDelegate {
    func deleteButtonSelected(forRowAt indexPath: IndexPath) {
        guard
            let userToDelete = userData(forIndex: indexPath)
        else { return }

        interactor?.doRemoveRandomUser(userToDelete, fromUsers: randomUsers)
    }
}
