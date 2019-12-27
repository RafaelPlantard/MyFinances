//
//  AddIncomeWorker.swift
//  Income
//
//  Created by Rafael Ferreira on 12/26/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import CoreData

final class AddIncomeWorker {
    private let store: IncomesStoreProtocol

    // MARK: Initializer

    init(store: IncomesStoreProtocol) {
        self.store = store
    }

    // MARK: Functions

    func createIncome(incomeToCreate: Income, then handler: (Result<Void, Error>) -> Void) {
        store.save(income: incomeToCreate, then: handler)
    }
}
