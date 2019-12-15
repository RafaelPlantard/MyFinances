//
//  IncomeCoordinator.swift
//  Income
//
//  Created by Rafael Ferreira on 12/15/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import Core
import UIKit

final class IncomeCoordinator: Coordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: Coordinator conforms

    func start() {
        let incomeViewController = IncomeViewControler()

        navigationController.setViewControllers([incomeViewController], animated: true)
    }
}
