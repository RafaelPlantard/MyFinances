//
//  IncomeListPresenter.swift
//  Income
//
//  Created by Rafael Ferreira on 12/26/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

protocol IncomeListPresentationLogic: AnyObject {
    func presentIncomes(response: IncomeList.FetchIncomes.Response)
    func presentEditIncome(response: IncomeList.DeleteIncome.Response)
    func presentEditIncome(error: Error)
}

final class IncomeListPresenter: IncomeListPresentationLogic {
    weak var viewController: IncomeListDisplayLogic?

    // MARK: Private constants

    private let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        return formatter
    }()

    // MARK: IncomeListPresentationLogic conforms

    func presentIncomes(response: IncomeList.FetchIncomes.Response) {
        let displayedIncomes = response.incomes.map({ [currencyFormatter] (income: Income) -> IncomeList.FetchIncomes.ViewModel.DisplayedIncome in
            let amount = NSNumber(value: income.amount)
            let value = currencyFormatter.string(from: amount)

            return IncomeList.FetchIncomes.ViewModel.DisplayedIncome(name: income.name, value: value)
        })

        let viewModel = IncomeList.FetchIncomes.ViewModel(displayedIncomes: displayedIncomes)

        viewController?.displayFetchedIncomes(viewModel: viewModel)
    }

    func presentEditIncome(response: IncomeList.DeleteIncome.Response) {
        let displayedIncomes = response.incomes.map({ [currencyFormatter] (income: Income) -> IncomeList.DeleteIncome.ViewModel.DisplayedIncome in
            let amount = NSNumber(value: income.amount)
            let value = currencyFormatter.string(from: amount)

            return IncomeList.DeleteIncome.ViewModel.DisplayedIncome(name: income.name, value: value)
        })

        let viewModel = IncomeList.DeleteIncome.ViewModel(
            displayedIncomes: displayedIncomes, deletedIndexPath: response.deletedIndexPath
        )

        viewController?.displayDeletedIncome(viewModel: viewModel)
    }

    func presentEditIncome(error: Error) {
        viewController?.displayDeletedIncomeError()
    }
}
