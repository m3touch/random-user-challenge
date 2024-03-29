//
//  RandomUserListViewController.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

class RandomUserListViewController: UIViewController, RandomUserListViewControllerProtocol, UIInstantiable, VIPConfigurable {

    // MARK: - Properties

    var interactor: RandomUserListInteractorProtocol?
    var router: RandomUserListRouterProcotol?

    private var currentPage = 0
    fileprivate var infiniteTableViewController = InfiniteTableViewController(style: .plain)
    fileprivate var randomUsers: [RandomUser] = []
    fileprivate var filteredRandomUsers: [RandomUser] = []
    fileprivate var isFilteringUsers: Bool = false
    fileprivate let filterButtonCategory: [RandomUserFilterCategory] = [.name, .surname, .email]

    @IBOutlet weak var usersTableViewContainer: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        showLoadingIndicator()
        interactor?.doFetchRandomUsers(randomUsers, forPage: currentPage+1)
    }

    override func viewWillDisappear(_ animated: Bool) {
        hideKeyboard()
        super.viewWillDisappear(animated)
    }

    // MARK: - VIP Impelementation

    func displayFetchRandomUsers(_ updatedUsers: [RandomUser], currentPage: Int, error: RandomUserListError?) {
        guard error == nil else {
            hideLoadingIndicator()
            showErrorAlert(error)
            return
        }

        filteredRandomUsers = []
        randomUsers = updatedUsers
        self.currentPage = currentPage

        if isFilteringUsers {
            filterRandomUsers()
            return
        }

        hideLoadingIndicator()
        reloadTableView()
    }

    func displayFilterRandomUsers(_ fileteredUsers: [RandomUser], appliedFilter: RandomUserFilter) {
        filteredRandomUsers = fileteredUsers
        hideLoadingIndicator()
        reloadTableView()
    }

    func displayRemoveRandomUser(_ removedUser: RandomUser, updatedUsers: [RandomUser]) {
        randomUsers = updatedUsers
        reloadTableView()
        showRemovedUserAlert(userData: removedUser)
    }

    // MARK: - IB Actions

    @IBAction func categoryFilterChanged(_ sender: Any) {
        isFilteringUsers = true
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
        usersTableViewContainer.isHidden = true
    }

    private func hideEmptyScreen() {
        usersTableViewContainer.isHidden = false
    }

    private func showErrorAlert(_ error: RandomUserListError?) {
        guard let randomUserListError = error else { return }

        switch randomUserListError {
        case .anyUserFound(userMessage: let message):
            showError(message: message, title: "Any user found")
        case .noMoreUsersToLoad(userMessage: let message):
            showError(message: message, title: "No more users")
        case .unableToLoadUsers(userMessage: let message):
            showError(message: message, title: "")
        }
    }

    private func showError(message: String?, title: String) {
        guard
            let errorMessage = message,
            !(errorMessage.isEmpty)
        else { return }

        showAlertTiteled(nil, text: errorMessage, dismissButtonText: "Dismiss")
    }

    private func showRemovedUserAlert(userData: RandomUser) {
        let alertTitle = "Removed User"
        let alertMessage = "\(userData.name ?? "-") \(userData.surname ?? "-"), with identifier: \(userData.id.uuidString), has been removed permanently."
        let alertDismissText = "Ok"

        showAlertTiteled(
            alertTitle,
            text: alertMessage,
            dismissButtonText: alertDismissText
        )
    }

    private func showLoadingIndicator() {
        activityIndicator.startAnimating()
    }

    private func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
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
        isFilteringUsers = false
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
    var dataSourceCount: Int {
        return isFilteringUsers ? filteredRandomUsers.count : randomUsers.count
    }

    func getCellDataForRowAt(indexPath: IndexPath) -> RandomUser? {
        return getRandomUser(forIndex: indexPath)
    }

    func deleteUserAtRow(indexPath: IndexPath) {
        guard
            let userToDelete = getRandomUser(forIndex: indexPath)
        else { return }

        interactor?.doRemoveRandomUser(userToDelete, fromUsers: randomUsers)
    }

    func loadMoreData() {
        showLoadingIndicator()
        interactor?.doFetchRandomUsers(randomUsers, forPage: currentPage+1)
    }

    func selectedCellAt(indexPath: IndexPath) {
        guard let selectedRandomUser = getRandomUser(forIndex: indexPath) else { return }
        router?.navigateToDetail(ofRandomUser: selectedRandomUser)
    }
}

// MARK: - UISearchBarDelegate Implementation

extension RandomUserListViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard (searchBar.text ?? "").isEmpty && isFilteringUsers else { return }

        clearFilteredUsersResults()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isFilteringUsers = true
        filterRandomUsers()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        hideKeyboard()
        clearFilteredUsersResults()
    }
}
