//
//  IncomeListWorker.swift
//  Income
//
//  Created by Rafael Ferreira on 12/25/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

final class IncomeListWorker {
    private let store: IncomesStoreProtocol

    // MARK: Initializer

    init(store: IncomesStoreProtocol) {
        self.store = store
    }

    // MARK: Functions

    func fetchIncomes(then handler: (([Income]) -> Void)) {
        store.fetchIncomes { result in
            do {
                handler(try result.get())
            } catch {
                handler([])
            }
        }
    }

    func deleteIncome(id: String, then handler: (Result<Void, Error>) -> Void) {
        store.deleteIncome(id: id, then: handler)
    }
}
