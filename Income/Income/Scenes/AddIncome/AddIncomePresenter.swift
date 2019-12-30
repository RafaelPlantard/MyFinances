//
//  AddIncomePresenter.swift
//  Income
//
//  Created by Rafael Ferreira on 12/23/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

protocol AddIncomePresentationLogic: AnyObject {
    func presentIncomeDate(response: AddIncome.FormatDate.Response)
    func presentFieldValidation(response: AddIncome.ValidateNewIncome.Response)
    func presentCreatedIncome()
    func presentFailure(error: Error)
}

final class AddIncomePresenter: AddIncomePresentationLogic {
    weak var viewController: AddIncomeDisplayLogic?

    // MARK: Private constants

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.setLocalizedDateFormatFromTemplate(dateFormat)

        return formatter
    }()

    private let dateFormat: String = {
        return DateFormatter.dateFormat(fromTemplate: "ddMMyyyy", options: 0, locale: Locale.current).or(.empty)
    }()

    // MARK: AddIncomePresentationLogic conforms

    func presentIncomeDate(response: AddIncome.FormatDate.Response) {
        let date = dateFormatter.string(from: response.date)
        let viewModel = AddIncome.FormatDate.ViewModel(date: date)

        viewController?.displayIncomeDate(viewModel: viewModel)
    }

    func presentFieldValidation(response: AddIncome.ValidateNewIncome.Response) {
        let viewModel = AddIncome.ValidateNewIncome.ViewModel(isEnabled: response.isValid)

        viewController?.displaySaveIncome(viewModel: viewModel)
    }

    func presentCreatedIncome() {
        viewController?.displayCreatedIncome()
    }

    func presentFailure(error: Error) {
        viewController?.displayError()
    }
}
