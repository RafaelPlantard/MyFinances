//
//  ListYearPresenter.swift
//  Calendar
//
//  Created by Rafael Ferreira on 12/31/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

protocol ListYearPresentationLogic {
    func presentFetchedYears(response: ListYear.FetchYears.Response)
    func presentFetchedMonths(response: ListYear.FetchMonths.Response)
}

final class ListYearPresenter: ListYearPresentationLogic {
    weak var viewController: ListYearDisplayLogic?

    // MARK: Private constants

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.setLocalizedDateFormatFromTemplate(yearDateFormat)

        return formatter
    }()

    private let yearDateFormat: String = {
        return DateFormatter.dateFormat(fromTemplate: "yyyy", options: 0, locale: Locale.current).or(.empty)
    }()

    private let monthDateFormat: String = {
        return DateFormatter.dateFormat(fromTemplate: "MMMM", options: 0, locale: Locale.current).or(.empty)
    }()

    // MARK: ListYearPresentationLogic conforms

    func presentFetchedYears(response: ListYear.FetchYears.Response) {
        let years = getDateFormatted(template: yearDateFormat, dates: response.dates)
        let viewModel = ListYear.FetchYears.ViewModel(years: years)

        viewController?.displayFetchedYears(viewModel: viewModel)
    }

    func presentFetchedMonths(response: ListYear.FetchMonths.Response) {
        let year = getDateFormatted(template: yearDateFormat, date: response.year)
        let months = getDateFormatted(template: monthDateFormat, dates: response.months)
        let viewModel = ListYear.FetchMonths.ViewModel(year: year, months: months)

        viewController?.displayFetchedMonths(viewModel: viewModel)
    }

    // MARK: Private functions

    private func getDateFormatted(template: String, date: Date) -> String {
        dateFormatter.setLocalizedDateFormatFromTemplate(template)

        return dateFormatter.string(from: date)
    }

    private func getDateFormatted(template: String, dates: [Date]) -> [String] {
        dateFormatter.setLocalizedDateFormatFromTemplate(template)

        return dates.map({ date in getDateFormatted(template: template, date: date) })
    }
}
