//
//  ListIncomePresenter.swift
//  Income
//
//  Created by Rafael Ferreira on 12/26/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

protocol ListIncomePresentationLogic: AnyObject {
    func presentIncomes(response: ListIncome.FetchIncomes.Response)
    func presentEditIncome(response: ListIncome.DeleteIncome.Response)
    func presentEditIncome(error: Error)
}

final class ListIncomePresenter: ListIncomePresentationLogic {
    weak var viewController: ListIncomeDisplayLogic?

    // MARK: Private constants

    private let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        return formatter
    }()

    // MARK: ListIncomePresentationLogic conforms

    func presentIncomes(response: ListIncome.FetchIncomes.Response) {
        let displayedIncomes = response.incomes.map({ [currencyFormatter] (income: Income) -> ListIncome.FetchIncomes.ViewModel.DisplayedIncome in
            let amount = NSNumber(value: income.amount)
            let value = currencyFormatter.string(from: amount)

            return ListIncome.FetchIncomes.ViewModel.DisplayedIncome(name: income.name, value: value)
        })

        let total = response.incomes.total(formatter: currencyFormatter)

        let viewModel = ListIncome.FetchIncomes.ViewModel(displayedIncomes: displayedIncomes, total: total)

        viewController?.displayFetchedIncomes(viewModel: viewModel)
    }

    func presentEditIncome(response: ListIncome.DeleteIncome.Response) {
        let displayedIncomes = response.incomes.map({ [currencyFormatter] (income: Income) -> ListIncome.DeleteIncome.ViewModel.DisplayedIncome in
            let amount = NSNumber(value: income.amount)
            let value = currencyFormatter.string(from: amount)

            return ListIncome.DeleteIncome.ViewModel.DisplayedIncome(name: income.name, value: value)
        })

        let total = response.incomes.total(formatter: currencyFormatter)

        let viewModel = ListIncome.DeleteIncome.ViewModel(
            displayedIncomes: displayedIncomes, total: total, deletedIndexPath: response.deletedIndexPath
        )

        viewController?.displayDeletedIncome(viewModel: viewModel)
    }

    func presentEditIncome(error: Error) {
        viewController?.displayDeletedIncomeError()
    }
}

extension Array where Element == Income {
    func total(formatter: NumberFormatter) -> String? {
        let totalAmount = map({ income in income.amount }).reduce(0, +)
        let totalAsNumber = NSNumber(value: totalAmount)

        return formatter.string(from: totalAsNumber)
    }
}
