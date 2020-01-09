//
//  OperationSelectorCoordinator.swift
//  OperationSelector
//
//  Created by Rafael Ferreira on 1/3/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

import Core
import UIKit

public final class OperationSelectorCoordinator: NSObject, Coordinator, ListOperationViewControllerDelegate,
    UINavigationControllerDelegate {

    private let navigationController: UINavigationController

    // MARK: Variables

    public weak var delegate: OperationSelectorCoordinatorDelegate?

    // MARK: Initializers

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: Coordinator conforms

    public func start() {
        let store: OperationsStoreProtocol = OperationsMemoryStore()
        let presenter = ListOperationPresenter()
        let interactor: ListOperationBusinessLogic = ListOperationInteractor(store: store, presenter: presenter)
        let listOperationViewController = ListOperationViewController(interactor: interactor)
        listOperationViewController.delegate = self
        presenter.viewController = listOperationViewController

        navigationController.pushViewController(listOperationViewController, animated: true)
    }

    // MARK: ListOperationViewControllerDelegate conforms

    func listOperationDidSelectIncomeOperation(_ viewController: ListOperationViewController) {
        delegate?.operationSelectorCoordinatorDidSelectIncomeFinish(self)
    }

    // MARK: UINavigationControllerDelegate conforms

    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController, animated: Bool) {
        CheckLastControllerPoppedFrom(navigationController: navigationController).onPop(
            of: ListOperationViewController.self, delegate: delegate, using: self
        )
    }
}
