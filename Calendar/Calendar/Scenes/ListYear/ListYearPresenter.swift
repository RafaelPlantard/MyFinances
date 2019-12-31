//
//  ListYearPresenter.swift
//  Calendar
//
//  Created by Rafael Ferreira on 12/31/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

protocol ListYearPresentationLogic {
    func presentFetchedYears(response: ListYear.FetchYears.Response)
}

final class ListYearPresenter: ListYearPresentationLogic {
    weak var viewController: ListYearDisplayLogic?

    // MARK: Private constants

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.setLocalizedDateFormatFromTemplate(dateFormat)

        return formatter
    }()

    private let dateFormat: String = {
        return DateFormatter.dateFormat(fromTemplate: "yyyy", options: 0, locale: Locale.current).or(.empty)
    }()

    // MARK: ListYearPresentationLogic conforms

    func presentFetchedYears(response: ListYear.FetchYears.Response) {
        let years = response.dates.map { [dateFormatter] date in dateFormatter.string(from: date) }
        let viewModel = ListYear.FetchYears.ViewModel(years: years)

        viewController?.displayFetchedYears(viewModel: viewModel)
    }
}
