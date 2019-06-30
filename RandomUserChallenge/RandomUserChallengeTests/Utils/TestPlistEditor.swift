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

    func loadPlist(named plistName: String) -> [String] {
        return savedIds
    }

    func addStringToPlist(named plistName: String, value stringToAdd: String) {
        savedIds.append(stringToAdd)
    }
}
