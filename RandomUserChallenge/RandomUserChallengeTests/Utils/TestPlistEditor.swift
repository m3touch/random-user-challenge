//
//  TestPlistEditor.swift
//  RandomUserChallengeTests
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

@testable import RandomUserChallenge

class TestPlistEditor: PlistEditorProtocol {
    var savedIds: [String] = []

    func loadPlist(withName plistName: String) -> [String] {
        return savedIds
    }

    func addStringToPlist(withName plistName: String, value stringToAdd: String) {
        savedIds.append(stringToAdd)
    }
}
