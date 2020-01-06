//
//  OperationSelectorCoordinator.swift
//  OperationSelector
//
//  Created by Rafael Ferreira on 1/3/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

import Core
import UIKit

public final class OperationSelectorCoordinator: Coordinator {
    private let navigationController: UINavigationController

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
        presenter.viewController = listOperationViewController

        navigationController.pushViewController(listOperationViewController, animated: true)
    }
}
