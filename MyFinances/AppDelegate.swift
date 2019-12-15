//
//  AppDelegate.swift
//  MyFinances
//
//  Created by Rafael Ferreira on 12/15/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func applicationDidFinishLaunching(_ application: UIApplication) {
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
