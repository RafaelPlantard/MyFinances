//
//  ListOperationWorker.swift
//  OperationSelector
//
//  Created by Rafael Ferreira on 1/5/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

final class ListOperationWorker {
    private let store: OperationsStoreProtocol

    // MARK: Initializer

    init(store: OperationsStoreProtocol) {
        self.store = store
    }

    // MARK: Functions

    func fetchOperations(then handler: (Result<[Operation], Error>) -> Void) {
        store.fetchOperations(then: handler)
    }
}
