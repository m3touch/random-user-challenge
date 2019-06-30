//
//  Globals.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 30/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

struct Globals {
    private init() {}

    enum LaunchArgument {
        static let uiTestLaunching = "isUITesting"
        static let resetPersistanceKey = "resetPersistance"
    }

    enum Persistance {
        static let plistName = "deletedRandomUsers"
    }

    enum Image {
        static let placeholder = ""
    }
}
