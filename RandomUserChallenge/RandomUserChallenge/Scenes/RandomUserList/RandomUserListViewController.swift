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
    fileprivate let filterButtonCategory: [RandomUserFilterCategory] = [.name, .surname, .email]

    @IBOutlet weak var usersTableViewContainer: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        interactor?.doFetchRandomUsers(forPage: currentPage+1)
    }

    override func viewWillDisappear(_ animated: Bool) {
        hideKeyboard()
        super.viewWillDisappear(animated)
    }

    // MARK: - VIP Impelementation

    func displayFetchRandomUsers(_ newUsers: [RandomUser], currentPage: Int, error: RandomUserListError?) {
        guard error == nil else { return } // TODO -> Manage the errors after fetching users

        filteredRandomUsers = []
        randomUsers.append(contentsOf: newUsers)
        self.currentPage = currentPage
        // TODO: If there is an applied filter, must filter the results, not reload the table view
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

    // MARK: - IB Actions
    @IBAction func categoryFilterChanged(_ sender: Any) {
        filterRandomUsers()
    }

    // MARK: - Private Interface

    private func setupUI() {
        self.title = "Random User List"
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

    private func showRemovedUserAlert(userData: RandomUser) {
        let alertTitle = "Removed User"
        let alertMessage = "\(userData.name ?? "-") \(userData.surname ?? "-"), with identifier: \(userData.id.uuidString), has been removed permanently."
        let alertDismissText = "Ok"

        showAlert(
            titled: alertTitle,
            text: alertMessage,
            dismissButtonText: alertDismissText
        )
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

    fileprivate func hideKeyboard() {
        searchBar.resignFirstResponder()
    }

    fileprivate func clearFilteredUsersResults() {
        filteredRandomUsers = []
        reloadTableView()
    }

    fileprivate func filterRandomUsers() {
        hideKeyboard()
        guard
            let typedText = searchBar.text,
            !typedText.isEmpty
        else { return }

        let searchFilter = RandomUserFilter(
            category: filterButtonCategory[filterSegmentedControl.selectedSegmentIndex],
            searchValue: typedText
        )

        interactor?.doFilterRandomUsers(randomUsers, withFilter: searchFilter)
    }
}

// MARK: - InfiniteTableViewControllerDelegate Implementation

extension RandomUserListViewController: InfiniteTableViewControllerDelegate {
    var infiniteTableViewDataSource: [RandomUser] {
        return isFilteringUsers ? filteredRandomUsers : randomUsers
    }

    func getCellDataForRowAt(indexPath: IndexPath) -> RandomUser? {
        return getRandomUser(forIndex: indexPath)
    }

    func deleteUserAtRow(indexPath: IndexPath) {
        guard
            let userToDelete = getRandomUser(forIndex: indexPath)
        else { return }

//        infiniteTableViewController.tableView.deleteRows(at: [indexPath], with: .fade)
        interactor?.doRemoveRandomUser(userToDelete, fromUsers: randomUsers)
    }
}

// MARK: - UISearchBarDelegate Implementation

extension RandomUserListViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard (searchBar.text ?? "").isEmpty else { return }

        clearFilteredUsersResults()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterRandomUsers()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        hideKeyboard()
        clearFilteredUsersResults()
    }
}
