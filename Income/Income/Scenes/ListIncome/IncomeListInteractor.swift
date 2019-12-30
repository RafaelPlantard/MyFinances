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
    func editIncome(style: UITableViewCell.EditingStyle, indexPath: IndexPath)
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
        worker.fetchIncomes { [weak self] incomes in
            if let self = self {
                self.incomes = incomes

                let incomes = IncomeList.FetchIncomes.Response(incomes: incomes)

                self.presenter.presentIncomes(response: incomes)
            }

        }
    }

    func editIncome(style: UITableViewCell.EditingStyle, indexPath: IndexPath) {
    }
}
