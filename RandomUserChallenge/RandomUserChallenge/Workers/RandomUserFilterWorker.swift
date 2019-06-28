//
//  RandomUserFilterWorker.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import Foundation

final class RandomUserFilterWorker {

    /**
     Filters the provided RandomUser sequence given the provided filter and search value.

     The filter category will specify the property that will be evaluated for the filtering. The search value will be
     applied to the given property to determinate if the entity must be taken as result.

     - properties:
         - users: The sequence of users to be filtered
         - filter: The filter conditions to execute the filtering of the provided sequence.
     */
    static func filterRandomUsers(_ users: [RandomUser], byFilter filter: RandomUserFilter) -> [RandomUser] {
        switch filter.category {
        case .name:
            return filterByName(users, searchValue: filter.searchValue)
        case .surname:
            return filterBySurname(users, searchValue: filter.searchValue)
        case .email:
            return filterByEmail(users, searchValue: filter.searchValue)
        }
    }

    /**
     Filters the provided RandomUser sequence removing the ones that match with the provided uuids.

     - properties:
         - unwantedUserIds: The sequence of the random users ids that have to be removed from the initial sequence.
         - users: The initial sequence of users to apply the filter.
     */
    static func removeUnwantedUsers(_ unwantedUserIds: [UUID], fromUsers users: [RandomUser]) -> [RandomUser] {
        return users.filter { user in !unwantedUserIds.contains(user.id) }
    }

    // MARK: - Private Interface

    private static func filterByName(_ users: [RandomUser], searchValue: String) -> [RandomUser] {
        return users.filter { user in (user.name ?? "").lowercased().contains(searchValue.lowercased()) }
    }

    private static func filterByEmail(_ users: [RandomUser], searchValue: String) -> [RandomUser] {
        return users.filter { user in (user.email ?? "").lowercased().contains(searchValue.lowercased()) }
    }

    private static func filterBySurname(_ users: [RandomUser], searchValue: String) -> [RandomUser] {
        return users.filter { user in (user.surname ?? "").lowercased().contains(searchValue.lowercased()) }
    }
}
