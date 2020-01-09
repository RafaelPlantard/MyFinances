//
//  OperationSelectorCoordinatorDelegate.swift
//  OperationSelector
//
//  Created by Rafael Ferreira on 1/7/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

import Core

public protocol OperationSelectorCoordinatorDelegate: CoordinatorDelegate {
    func operationSelectorCoordinatorDidSelectIncomeFinish(_ coordinator: OperationSelectorCoordinator)
}
