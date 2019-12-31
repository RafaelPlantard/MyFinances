//
//  CalendarCoordinator.swift
//  Calendar
//
//  Created by Rafael Ferreira on 12/31/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import Core
import UIKit

public final class CalendarCoordinator: Coordinator {
    private let navigationController: UINavigationController

    // MARK: Initializer

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: Coordinator conforms

    public func start() {
        let presenter = ListYearPresenter()
        let interactor = ListYearInteractor(store: YearsMemoryStore(), presenter: presenter)
        let listYearViewController = ListYearViewController(interactor: interactor)
        presenter.viewController = listYearViewController

        navigationController.setViewControllers([listYearViewController], animated: true)
    }
}
