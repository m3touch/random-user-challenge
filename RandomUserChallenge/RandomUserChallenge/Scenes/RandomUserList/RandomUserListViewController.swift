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

    var interactor: RandomUserListInteractorProtocol?

    private var currentPage = 0
    fileprivate var infiniteTableViewController = InfiniteTableViewController(style: .plain)
    fileprivate var randomUsers: [RandomUser] = []
    fileprivate var filteredRandomUsers: [RandomUser] = []
    fileprivate var isFilteringUsers: Bool {
        return filteredRandomUsers.count != 0
    }

    @IBOutlet weak var usersTableViewContainer: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        interactor?.doFetchRandomUsers(forPage: currentPage+1)
    }

    // MARK: - VIP Impelementation

    func displayFetchRandomUsers(_ newUsers: [RandomUser], currentPage: Int, error: RandomUserListError?) {
        guard error == nil else { return } // TODO -> Manage the errors after fetching users

        randomUsers.append(contentsOf: newUsers)
        self.currentPage = currentPage
        reloadTableView()
    }

    func displayFilterRandomUsers(_ fileteredUsers: [RandomUser], appliedFilter: RandomUserFilter) {
        filteredRandomUsers = fileteredUsers
        reloadTableView()
    }

    func displayRemoveRandomUser(_ removedUser: RandomUser?, updatedRandomUsers: [RandomUser], error: RandomUserListError?) {
        // TODO --> MANAGE ERROR REMOVING USER
        guard let removedUserData = removedUser else { return }

        randomUsers = updatedRandomUsers
        reloadTableView()
        showRemovedUserAlert(userData: removedUserData)
    }

    // MARK: - Private Interface

    private func setupUI() {
        loadTableView()
        showEmptyScreen()
    }

    private func loadTableView() {
        infiniteTableViewController.delegate = self
        addChild(infiniteTableViewController)
        infiniteTableViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        infiniteTableViewController.view.frame = usersTableViewContainer.bounds
        usersTableViewContainer.addSubview(infiniteTableViewController.tableView)
        infiniteTableViewController.didMove(toParent: self)
    }

    private func reloadTableView() {
        let dataSource = isFilteringUsers ? filteredRandomUsers : randomUsers
        if dataSource.count != 0 {
            hideEmptyScreen()
            infiniteTableViewController.tableView.reloadData()
        } else {
            showEmptyScreen()
        }
    }

    private func showEmptyScreen() {
        // TODO: Customize the message for the given filter?
        usersTableViewContainer.isHidden = true
    }

    private func hideEmptyScreen() {
        usersTableViewContainer.isHidden = false
    }

    fileprivate func getRandomUser(forIndex indexPath: IndexPath) -> RandomUser? {
        if isFilteringUsers && filteredRandomUsers.count > indexPath.row {
            return filteredRandomUsers[indexPath.row]
        }

        if !isFilteringUsers && randomUsers.count > indexPath.row {
            return randomUsers[indexPath.row]
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

extension RandomUserListViewController: InfiniteTableViewControllerDelegate {
    var infiniteTableViewDataSource: [RandomUser] {
        return isFilteringUsers ? filteredRandomUsers : randomUsers
    }

    func getCellDataForRowAt(indexPath: IndexPath) -> RandomUser? {
        return getRandomUser(forIndex: indexPath)
    }
}

extension RandomUserListViewController: RandomUserCellDelegate {
    func deleteButtonSelected(forRowAt indexPath: IndexPath) {
        guard
            let userToDelete = getRandomUser(forIndex: indexPath)
        else { return }

        interactor?.doRemoveRandomUser(userToDelete, fromUsers: randomUsers)
    }
}
