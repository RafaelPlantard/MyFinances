//
//  AddIncomeInteractor.swift
//  Income
//
//  Created by Rafael Ferreira on 12/23/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

protocol AddIncomeBusinessLogic: AnyObject {
    func formatIncomeDate(request: AddIncome.FormatDate.Request)
}

final class AddIncomeInteractor: AddIncomeBusinessLogic {
    private let presenter: AddIncomePresentationLogic

    init(presenter: AddIncomePresentationLogic) {
        self.presenter = presenter
    }

    // MARK: AddIncomeBusinessLogic conforms

    func formatIncomeDate(request: AddIncome.FormatDate.Request) {
        let response = AddIncome.FormatDate.Response(date: request.date)

        presenter.presentIncomeDate(response: response)
    }
}
