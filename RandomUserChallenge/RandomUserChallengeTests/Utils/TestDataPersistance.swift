//
//  TestDataPersistance.swift
//  RandomUserChallengeTests
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

@testable import RandomUserChallenge

class TestDataPersistance: DataPersistanceProtocol {
    var updatedDeletedUsers: [RandomUser] = []
    var deletedIds: [String] = []

    func deletePermanentlyRandomUser(_ randomUser: RandomUser) {
        deletedIds.append(randomUser.id.uuidString)
    }

    func removeDeletedRandomUsersFrom(_ randomUsers: [RandomUser]) -> [RandomUser] {
        return updatedDeletedUsers
    }
}
