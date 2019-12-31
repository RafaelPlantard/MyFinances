//
//  ListYearWorker.swift
//  Calendar
//
//  Created by Rafael Ferreira on 12/31/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

final class ListYearWorker {
    private let store: YearsStoreProtocol

    // MARK: Initializers

    init(store: YearsStoreProtocol) {
        self.store = store
    }

    // MARK: Functions

    func fetchYears(then handler: (Result<[Date], Error>) -> ()) {
        store.fetchYears(then: handler)
    }
}
