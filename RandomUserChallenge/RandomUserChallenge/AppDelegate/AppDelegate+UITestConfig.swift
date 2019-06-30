//
//  AppDelegate+UITestConfig.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit
import OHHTTPStubs

extension AppDelegate {
    func configureUITestStubs(_ arguments: [String]) {
        loadThreeStubbedRandomUsersForFirstPage()
        avoidLoadingMoreUsersForNextPages()

        if arguments.contains(Globals.LaunchArgument.resetPersistanceKey) {
            PlistEditor().clearPlist(named: Globals.Persistance.plistName)
        }
    }

    private func loadThreeStubbedRandomUsersForFirstPage() {
        stub(condition: isHost("randomuser.me") && containsQueryParams(["page": "1"])) { _ in
            guard let path = OHPathForFile("fetch_random_users.json", type(of: self)) else {
                preconditionFailure("Could not find expected file in test bundle")
            }

            return OHHTTPStubsResponse(
                fileAtPath: path,
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
    }

    private func avoidLoadingMoreUsersForNextPages() {
        stub(condition: isHost("randomuser.me") && !containsQueryParams(["page": "1"])) { _ in
            return OHHTTPStubsResponse(jsonObject: [:], statusCode: 200, headers: ["Content-Type": "application/json"])
        }
    }
}
