//
//  RandomUserListProtocols.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

/**
 RandomUserList view logic.
 */
protocol RandomUserListViewControllerProtocol: class {

    /**
     Updates the UI to show the new fetched random users to the user.

     - parameters:
         - updatedUsers: The updated sequence of users with the new fetched ones for the given page.
         - currentPage: The page from where the random users have been provided.
         - error: An error that occurred while fetching the required users with the description.
     */
    func displayFetchRandomUsers(_ updatedUsers: [RandomUser], currentPage: Int, error: RandomUserListError?)

    /**
     Displays the filtered random users to the user. If the filter has no matches to the ones provided, an empty
     sequence will be returned.

     - parameters:
         - filteredUsers: The users that matched the provided filtering properties. Can be empty.
         - appliedFilter: The filter that has been applied to the resultant sequence.
     */
    func displayFilterRandomUsers(_ fileteredUsers: [RandomUser], appliedFilter: RandomUserFilter)

    /**
     Updates the UI after the random user has been removed.

     - parameters:
        - removedUser: The user that was asked to be removed.
        - updatedUsers: The resulting list after removing the users.
     */
    func displayRemoveRandomUser(_ removedUser: RandomUser, updatedUsers: [RandomUser])
}

/**
 RandomUserList business logic.
 */
protocol RandomUserListInteractorProtocol {
    /**
     Defines the number of random users that the interactor should fetch per page.
     */
    var resultsPerPage: Int { get }

    /**
     Fetches random users for the given page.

     - parameters:
        - currentUsers: The current users sequence to be updated with the new downloaded ones.
        - nextPage: The page to be fetched.
     */
    func doFetchRandomUsers(_ currentUsers: [RandomUser], forPage nextPage: Int)

    /**
     Applies a filter to the provided random users with the specified filter parameters.

     If the filter search value is an empty string or not provided the resulting sequence after applying the filter will
     be the same as the initially provided one.

     - parameters:
         - currentUsers: The current users sequence to be filtered.
         - filter: The filter to be applied to the provided random users sequence.
     */
    func doFilterRandomUsers(_ currentUsers: [RandomUser], withFilter filter: RandomUserFilter)

    /**
     Removes the given random user from the system permanently.

     - parameters:
         - user: The user to be removed.
         - currentUsers: The users sequence where the removed user exists.
     */
    func doRemoveRandomUser(_ user: RandomUser, fromUsers currentUsers: [RandomUser])
}

/**
 RandomUserList presentation logic.
 */
protocol RandomUserListPresenterProcotol {

    /**
     Presents to the view controller the random users with the fetched random users.

     If there are no more users to retrieve the provided users sequence should be the same, the current page will be the previous page
     from the one provided (not less than 0), and a `noMoreUsersToLoad` error will be returned.

     - parameters:
         - updatedUsers: The sequence of users to be shown.
         - currentPage: The page that has been provided information from.
         - error: A problem that has occurred during the random users fetch.
     */
    func presentFetchRandomUsers(_ updatedUsers: [RandomUser], currentPage: Int, error: APIError?)

    /**
     Presents to the view controller the provided random users with the defined filter applied. If the filter has no matches to the
     random users provided, an empty sequence will be returned.

     - parameters:
         - filteredUsers: The sequence of filtered users from the provided initial sequence.
         - appliedFilter: The filter that has been provided.
     */
    func presentFilterRandomUsers(_ filteredUsers: [RandomUser], appliedFilter: RandomUserFilter)

    /**
     Presents to the view the remove user result.

     - parameters:
         - removedUser: The user that has been asked to be removed.
         - updatedUsers: The resulting array of random users after removing the user.
     */
    func presentRemoveRandomUser(_ removedUser: RandomUser, updatedUsers: [RandomUser])
}

/**
 RandomUserList router logic.
 */
protocol RandomUserListRouterProcotol {
    /**
     Routes to the random user detail.

     - parameters:
         - userData: The user information to feed the user detail.
     */
    func navigateToDetail(ofRandomUser userData: RandomUser)
}
