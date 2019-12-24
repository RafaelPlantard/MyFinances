//
//  IncomeCoordinator.swift
//  Income
//
//  Created by Rafael Ferreira on 12/15/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import Core
import UIKit

public final class IncomeCoordinator: Coordinator, IncomeListViewControllerDelegate, AddIncomeViewControllerDelegate {
    private let navigationController: UINavigationController

    // MARK: Initializer

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: Coordinator conforms

    public func start() {
        let incomeListViewController = IncomeListViewControler()
        incomeListViewController.delegate = self

        navigationController.setViewControllers([incomeListViewController], animated: true)
    }

    // MARK: IncomeListViewControllerDelegate conforms

    func incomeListRightBarButtonItemTapped(_ viewController: IncomeListViewControler) {
        let presenter = AddIncomePresenter()
        let interactor = AddIncomeInteractor(presenter: presenter)
        let addIncomeViewController = AddIncomeViewController(interactor: interactor)
        presenter.viewController = addIncomeViewController
        addIncomeViewController.delegate = self

        let newNavigationController = UINavigationController(rootViewController: addIncomeViewController)
        newNavigationController.modalPresentationCapturesStatusBarAppearance = true

        navigationController.present(newNavigationController, animated: true, completion: nil)
    }

    // MARK: AddIncomeViewControllerDelegate conforms

    func addIncomeLeftBarButtonItemTapped(_ viewController: AddIncomeViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

    func addIncomeRightBarButtonItemTapped(_ viewController: AddIncomeViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
