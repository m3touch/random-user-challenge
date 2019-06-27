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

        let listViewController = RandomUserListViewController.instiantate()
        let rootNavigationController = UINavigationController(rootViewController: listViewController)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}
