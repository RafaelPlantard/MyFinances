//
//  AddIncomePresenter.swift
//  Income
//
//  Created by Rafael Ferreira on 12/23/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

protocol AddIncomePresentationLogic: AnyObject {
    func presentIncomeDate(response: AddIncome.FormatDate.Response)
}

final class AddIncomePresenter: AddIncomePresentationLogic {
    weak var viewController: AddIncomeDisplayLogic?

    // MARK: Private constants

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none

        return formatter
    }()

    // MARK: AddIncomePresentationLogic conforms

    func presentIncomeDate(response: AddIncome.FormatDate.Response) {
        let date = dateFormatter.string(from: response.date)
        let viewModel = AddIncome.FormatDate.ViewModel(date: date)

        viewController?.displayIncomeDate(viewModel: viewModel)
    }
}
