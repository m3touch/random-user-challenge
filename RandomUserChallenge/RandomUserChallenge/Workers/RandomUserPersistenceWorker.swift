//
//  RandomUserPersistenceWorker.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

final class RandomUserPersistenceWorker: DataPersistanceProtocol {

    private let plistEditor: PlistEditorProtocol

    init(plistEditor: PlistEditorProtocol) {
        self.plistEditor = plistEditor
    }

    private enum Constants {
        static let randomUserPlistName = "deletedRandomUsers"
    }

    func deletePermanentlyRandomUser(_ randomUser: RandomUser) { // TODO: ADD TESTS
        plistEditor.addStringToPlist(withName: Constants.randomUserPlistName, value: randomUser.id.uuidString)
    }

    func removeDeletedRandomUsersFrom(_ randomUsers: [RandomUser]) -> [RandomUser] { // TODO: ADD TEST
        let deletedIds = loadDeletedRandomUserIds()
        var cleanedUpRandomUsers: [RandomUser] = []

        for user in randomUsers {
            if !deletedIds.contains(user.id.uuidString) {
                cleanedUpRandomUsers.append(user)
            }
        }

        return cleanedUpRandomUsers
    }

    // MARK: - Private Interface

    private func loadDeletedRandomUserIds() -> [String] {
        return plistEditor.loadPlist(withName: Constants.randomUserPlistName)
    }
}
