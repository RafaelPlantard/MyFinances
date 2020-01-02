//
//  ListYearInteractor.swift
//  Calendar
//
//  Created by Rafael Ferreira on 12/31/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

protocol ListYearBusinessLogic {
    func fetchYears()
    func fetchMonths(request: ListYear.FetchMonths.Request)
}

final class ListYearInteractor: ListYearBusinessLogic {
    private let worker: ListYearWorker
    private let presenter: ListYearPresentationLogic

    // MARK: Private variables

    private var years: [Date] = []

    // MARK: Initializer

    init(store: YearsStoreProtocol, presenter: ListYearPresentationLogic) {
        self.worker = ListYearWorker(store: store)
        self.presenter = presenter
    }

    // MARK: ListYearBusinessLogic conforms

    func fetchYears() {
        worker.fetchYears { [weak self] result in
            let years: [Date]

            do {
                years = try result.get()
            } catch {
                years = []
            }

            let response = ListYear.FetchYears.Response(dates: years)

            if let self = self {
                self.years = years
                self.presenter.presentFetchedYears(response: response)
            }
        }
    }

    func fetchMonths(request: ListYear.FetchMonths.Request) {
    let year = years[request.indexPath.row]

        worker.fetchMonths(of: year) { [weak self] result in
            let months: [Date]

            do {
                months = try result.get()
            } catch {
                months = []
            }

            let response = ListYear.FetchMonths.Response(year: year, months: months)

            self?.presenter.presentFetchedMonths(response: response)
        }
    }
}
