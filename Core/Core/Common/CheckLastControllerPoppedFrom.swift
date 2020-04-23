//
//  CheckLastControllerPoppedFrom.swift
//  Core
//
//  Created by Rafael Ferreira on 1/9/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

import UIKit

public final class CheckLastControllerPoppedFrom<T: UIViewController> {
    private let navigationController: UINavigationController

    // MARK: Initializer

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: Functions

    public func onPop(delegate: CoordinatorDelegate?, using coordinator: Coordinator) {
        if isPoppingFromStack(of: T.self) {
            delegate?.finish(coordinator)
        }
    }

    // MARK: Private functions

    private func isPoppingFromStack<T: UIViewController>(of viewControllerType: T.Type) -> Bool {
        guard let transitionCoordinator = navigationController.transitionCoordinator,
            let fromViewController = transitionCoordinator.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController) else {
            return false
        }

        return type(of: fromViewController) == viewControllerType
    }
}
