//
//  OperationsMemoryStore.swift
//  OperationSelector
//
//  Created by Rafael Ferreira on 1/5/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

final class OperationsMemoryStore: OperationsStoreProtocol {
    func fetchOperations(then handler: (Result<[Operation], Error>) -> Void) {
        handler(.success([.income]))
    }
}
