//
//  ListOperationPresenter.swift
//  OperationSelector
//
//  Created by Rafael Ferreira on 1/5/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

protocol ListOperationPresentationLogic {
    func presentFetchedOperations(response: ListOperation.FetchOperations.Response)
    func presentIncomeOperation()
}

final class ListOperationPresenter: ListOperationPresentationLogic {
    weak var viewController: ListOperationDisplayLogic?

    // MARK: ListOperationPresentationLogic conforms

    func presentFetchedOperations(response: ListOperation.FetchOperations.Response) {
        let operations = response.operations.map({ operation in operation.description })
        let viewModel = ListOperation.FetchOperations.ViewModel(operations: operations)

        viewController?.displayFetchedOperations(viewModel: viewModel)
    }

    func presentIncomeOperation() {
        viewController?.displayIncomeOperation()
    }
}
