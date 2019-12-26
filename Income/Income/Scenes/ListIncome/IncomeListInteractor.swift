//
//  IncomeListInteractor.swift
//  Income
//
//  Created by Rafael Ferreira on 12/25/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

protocol IncomeListBusinessLogic {
    func fetchIncomes()
}

final class IncomeListInteractor: IncomeListBusinessLogic {
    private let worker: IncomeListWorker
    private let presenter: IncomeListPresentationLogic

    // MARK: Initializer

    init(store: IncomesStoreProtocol, presenter: IncomeListPresentationLogic) {
        self.worker = IncomeListWorker(store: store)
        self.presenter = presenter
    }

    // MARK: IncomeListBusinessLogic conforms

    func fetchIncomes() {
        worker.fetchOrders { [weak presenter] incomes in
            let incomes = IncomeList.FetchIncomes.Response(incomes: incomes)

            presenter?.presentOrders(response: incomes)
        }
    }
}
