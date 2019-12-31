//
//  ListYearInteractor.swift
//  Calendar
//
//  Created by Rafael Ferreira on 12/31/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

protocol ListYearBusinessLogic {
    func fetchYears()
}

final class ListYearInteractor: ListYearBusinessLogic {
    private let worker: ListYearWorker
    private let presenter: ListYearPresentationLogic

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

            self?.presenter.presentFetchedYears(response: response)
        }
    }
}
