//
//  ListOperationInteractor.swift
//  OperationSelector
//
//  Created by Rafael Ferreira on 1/4/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

protocol ListOperationBusinessLogic {
    func fetchOperations()
}

final class ListOperationInteractor: ListOperationBusinessLogic {
    private let worker: ListOperationWorker
    private let presenter: ListOperationPresentationLogic

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

            self?.presenter.presentFetchedOperations(response: response)
        }
    }
}
