//
//  AppDelegate.swift
//  MyFinances
//
//  Created by Rafael Ferreira on 12/15/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        let newWindow = UIWindow()
        newWindow.rootViewController = ViewController()
        newWindow.backgroundColor = .white
        newWindow.makeKeyAndVisible()

        window = newWindow
    }
}
