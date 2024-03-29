//
//  AppDelegate.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 martatarrago. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        processLaunchArguments()

        let listViewController = RandomUserListViewController.instiantate()
        listViewController.configureVIP()

        let rootNavigationController = UINavigationController(rootViewController: listViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()

        return true
    }

    private func processLaunchArguments() {
        let launchArguments = ProcessInfo.processInfo.arguments
        guard launchArguments.contains(Globals.LaunchArgument.uiTestLaunching) else { return }

        configureUITestStubs(launchArguments)
    }
}
