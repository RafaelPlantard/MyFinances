//
//  AddIncomeInteractor.swift
//  Income
//
//  Created by Rafael Ferreira on 12/23/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

protocol AddIncomeBusinessLogic: AnyObject {
    func formatIncomeDate(request: AddIncome.FormatDate.Request)
    func saveNewIncome(request: AddIncome.SaveNewIncome.Request)
}

final class AddIncomeInteractor: AddIncomeBusinessLogic {
    private let worker: AddIncomeWorker
    private let presenter: AddIncomePresentationLogic

    // MARK: Initializer

    init(store: IncomesStoreProtocol, presenter: AddIncomePresentationLogic) {
        self.worker = AddIncomeWorker(store: store)
        self.presenter = presenter
    }

    // MARK: AddIncomeBusinessLogic conforms

    func formatIncomeDate(request: AddIncome.FormatDate.Request) {
        let response = AddIncome.FormatDate.Response(date: request.date)

        presenter.presentIncomeDate(response: response)
    }

    func saveNewIncome(request: AddIncome.SaveNewIncome.Request) {
        let income = Income(
            name: request.incomeFormFields.name,
            amount: request.incomeFormFields.amount,
            date: request.incomeFormFields.date
        )

        worker.createIncome(incomeToCreate: income) { result in
            do {
                try result.get()

                presenter.presentCreatedIncome()
            } catch {
                presenter.presentFailure(error: error)
            }
        }
    }
}
