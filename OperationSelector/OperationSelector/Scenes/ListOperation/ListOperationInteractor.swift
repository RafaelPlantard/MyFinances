//
//  ListOperationInteractor.swift
//  OperationSelector
//
//  Created by Rafael Ferreira on 1/4/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

protocol ListOperationBusinessLogic {
    func fetchOperations()
    func selectOperation(request: ListOperation.SelectOperation.Request)
}

final class ListOperationInteractor: ListOperationBusinessLogic {
    private let worker: ListOperationWorker
    private let presenter: ListOperationPresentationLogic

    // MARK: Private variables

    private var operations: [Operation] = []

    // MARK: Initializer

    init(store: OperationsStoreProtocol, presenter: ListOperationPresentationLogic) {
        self.worker = ListOperationWorker(store: store)
        self.presenter = presenter
    }

    // MARK: ListOperationBusinessLogic conforms

    func fetchOperations() {
        worker.fetchOperations { [weak self] result in
            let operations: [Operation]

            do {
                operations = try result.get()
            } catch {
                operations = []
            }

            let response = ListOperation.FetchOperations.Response(operations: operations)

            if let self = self {
                self.operations = operations
                self.presenter.presentFetchedOperations(response: response)
            }
        }
    }

    func selectOperation(request: ListOperation.SelectOperation.Request) {
        let operation = operations[request.indexPath.row]

        if operation == .income {
            presenter.presentIncomeOperation()
        }
    }
}
