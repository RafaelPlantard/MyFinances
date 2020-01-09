//
//  AppCoordinator.swift
//  MyFinances
//
//  Created by Rafael Ferreira on 12/15/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import Calendar
import Core
import Income
import OperationSelector
import UIKit

final class AppCoordinator: Coordinator, CalendarCoordinatorDelegate, OperationSelectorCoordinatorDelegate {
    private let navigationController: UINavigationController
    private let window: UIWindow

    // MARK: Private variables

    private var childCoordinators: [Coordinator] = []

    // MARK: Initializer

    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }

    // MARK: Coordinator conforms

    func start() {
        setupWindow()
        showCalendar()
    }

    // MARK: CalendarCoordinatorDelegate conforms

    func calendarCoordinatorDidFinish(with date: Date, _ coordinator: CalendarCoordinator) {
        showOperationSelector()
    }

    // MARK: OperationSelectorCoordinatorDelegate conforms

    func operationSelectorCoordinatorDidSelectIncomeFinish(_ coordinator: OperationSelectorCoordinator) {
        showIncome()
    }

    func finish(_ coordinator: Coordinator) {
        childCoordinators.removeFirst(where: { item in item === coordinator })
        navigationController.delegate = childCoordinators.last as? UINavigationControllerDelegate
    }

    // MARK: Private functions

    private func setupWindow() {
        window.backgroundColor = .white
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func showIncome() {
        let incomeCoordinator = IncomeCoordinator(navigationController: navigationController)
        incomeCoordinator.delegate = self
        navigationController.delegate = incomeCoordinator
        childCoordinators.append(incomeCoordinator)
        incomeCoordinator.start()
    }

    private func showCalendar() {
        let calendarCoordinator = CalendarCoordinator(navigationController: navigationController)
        calendarCoordinator.delegate = self
        childCoordinators.append(calendarCoordinator)
        calendarCoordinator.start()
    }

    private func showOperationSelector() {
        let operationSelectorCoordinator = OperationSelectorCoordinator(navigationController: navigationController)
        navigationController.delegate = operationSelectorCoordinator
        operationSelectorCoordinator.delegate = self
        childCoordinators.append(operationSelectorCoordinator)
        operationSelectorCoordinator.start()
    }
}
