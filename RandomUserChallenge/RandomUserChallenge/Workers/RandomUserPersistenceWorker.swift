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

    func deletePermanentlyRandomUser(_ randomUser: RandomUser) {
        plistEditor.addStringToPlist(named: Globals.Persistance.plistName, value: randomUser.id.uuidString)
    }

    func removeDeletedRandomUsersFrom(_ randomUsers: [RandomUser]) -> [RandomUser] {
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
        return plistEditor.loadPlist(named: Globals.Persistance.plistName)
    }
}
