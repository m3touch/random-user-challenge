//
//  RandomUserListProtocols.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

protocol RandomUserListViewControllerProtocol: class {

    /**
     Updates the UI to show the new fetched random users to the user.

     - parameters:
         - newUsers: The sequence of new fetched users for the given page.
         - currentPage: The page from where the random users have been provided.
         - error: An error that occurred while fetching the required users with the message that has to be shown to the user.
     */
    func displayFetchRandomUsers(_ newUsers: [RandomUser], currentPage: Int, error: RandomUserListError?)

    /**
     Displays the filtered random users to the user. If the filter has no matches to the random users provided, an empty
     sequence will be returned.

     - parameters:
         - filteredUsers: The users that matched the provided filtering properties.
         - appliedFilter: The filter that has been applied to the resultant sequence.
     */
    func displayFilterRandomUsers(_ fileteredUsers: [RandomUser], appliedFilter: RandomUserFilter)

    /**
     Updates the UI after the random user has been removed.

     - parameters:
        - removedUser: The user that was asked to be removed.
        - updatedRandomUsers: The resulting list after removing the users.
        - error: Any error that occurred during the remove user process.
     */
    func displayRemoveRandomUser(_ removedUser: RandomUser, updatedRandomUsers: [RandomUser], error: RandomUserListError?)
}

protocol RandomUserListInteractorProtocol {
    /**
     Defines the number of random users that the interactor should fetch per page.
     */
    var resultsPerPage: Int { get }

    /**
     Fetches random users for the given page.

     - parameters:
        - nextPage: The page to be fetched.
     */
    func doFetchRandomUsers(forPage nextPage: Int)

    /**
     Applies a filter to the provided random users with the specified filter parameters.

     If the filter search value is an empty string or not provided the resulting sequence after applying the filter will
     be the same as the initially provided one.

     - parameters:
         - filter: The filter to be applied to the provided random users sequence.
     */
    func doFilterRandomUsers(_ users: [RandomUser], withFilter filter: RandomUserFilter)

    /**
     Removes the given random user for the system permanently.

     - parameters:
         - user: The user to be removed
     */
    func doRemoveRandomUser(_ user: RandomUser)
}

protocol RandomUserListPresenterProcotol {

    /**
     Presents to the view controller the fetched random users.

     If there are no more users to retrieve, empty new users will be provided, the current page will be the previous page
     from the one provided (not less than 0), and a `noMoreUsersToLoad` error will be returned.

     - parameters:
         - newUsers: The sequence of new retrieved users.
         - currentPage: The page that has been provided information from.
         - error: A problem that has occurred during the random users fetch.
     */
    func presentFetchRandomUsers(_ newUsers: [RandomUser], currentPage: Int, error: APIError?)

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
         - error: The error that occurred while removing the random user if any.
     */
    func presentRemoveRandomUser(_ removedUser: RandomUser?, error: Error?)
}
