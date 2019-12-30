//
//  IncomeListInteractor.swift
//  Income
//
//  Created by Rafael Ferreira on 12/25/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import class UIKit.UITableViewCell

protocol IncomeListBusinessLogic {
    func fetchIncomes()
    func editIncome(request: IncomeList.DeleteIncome.Request)
}

final class IncomeListInteractor: IncomeListBusinessLogic {
    private let worker: IncomeListWorker
    private let presenter: IncomeListPresentationLogic

    // MARK: Private variables

    private var incomes: [Income] = []

    // MARK: Initializer

    init(store: IncomesStoreProtocol, presenter: IncomeListPresentationLogic) {
        self.worker = IncomeListWorker(store: store)
        self.presenter = presenter
    }

    // MARK: IncomeListBusinessLogic conforms

    func fetchIncomes() {
        worker.fetchIncomes { [weak self] incomes in
            if let self = self {
                self.incomes = incomes

                let incomes = IncomeList.FetchIncomes.Response(incomes: incomes)

                self.presenter.presentIncomes(response: incomes)
            }
        }
    }

    func editIncome(request: IncomeList.DeleteIncome.Request) {
        if request.style == .delete {
            let indexPath = request.indexPath
            let incomeId = incomes[indexPath.row].id.uuidString

            worker.deleteIncome(id: incomeId) { [weak self] result in
                self?.onDeleteIncome(deletedIndexPath: indexPath, result: result)
            }
        }
    }

    // MARK: Private functions

    private func onDeleteIncome(deletedIndexPath: IndexPath, result: Result<Void, Error>) {
        do {
            try result.get()

            incomes.remove(at: deletedIndexPath.row)

            let response = IncomeList.DeleteIncome.Response(incomes: incomes, deletedIndexPath: deletedIndexPath)

            presenter.presentEditIncome(response: response)
        } catch {
            presenter.presentEditIncome(error: error)
        }
    }
}
