//
//  IncomeCoordinator.swift
//  Income
//
//  Created by Rafael Ferreira on 12/15/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import Core
import UIKit

public final class IncomeCoordinator: Coordinator {
    private let navigationController: UINavigationController

    // MARK: Initializer

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: Coordinator conforms

    public func start() {
        let incomeListViewController = IncomeListViewControler()

        navigationController.setViewControllers([incomeListViewController], animated: true)
    }
}
