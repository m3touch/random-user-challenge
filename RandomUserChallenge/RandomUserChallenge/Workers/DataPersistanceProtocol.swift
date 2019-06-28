//
//  DataPersistanceProtocol.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import Foundation

protocol DataPersistanceProtocol {

    /**
     Saves the user as a permanently deleted randomUser.

     - parameters:
         - randomUser: The random user to delete
     */
    func deletePermanentlyRandomUser(_ randomUser: RandomUser)

    /**
     Removes all the previously deleted random users from the provided random user sequence.

     - parameters:
         - randomUsers: The sequence from where the deleted random users must be deleted.

     - returns: The cleaned up sequence.
     */
    func removeDeletedRandomUsersFrom(_ randomUsers: [RandomUser]) -> [RandomUser]
}
