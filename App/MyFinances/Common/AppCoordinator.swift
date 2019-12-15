//
//  AppCoordinator.swift
//  MyFinances
//
//  Created by Rafael Ferreira on 12/15/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import Core
import Income
import UIKit

final class AppCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let window: UIWindow
    private var childCoordinators: [Coordinator] = []

    // MARK: Initializer

    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }

    // MARK: Coordinator conforms

    func start() {
        setupWindow()
        showIncome()
    }

    // MARK: Private functions

    private func setupWindow() {
        window.backgroundColor = .white
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func showIncome() {
        let incomeCoordinator = IncomeCoordinator(navigationController: navigationController)
        childCoordinators.append(incomeCoordinator)
        incomeCoordinator.start()
    }
}
