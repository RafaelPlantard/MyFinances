//
//  YearsMemoryStore.swift
//  Calendar
//
//  Created by Rafael Ferreira on 12/31/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

final class YearsMemoryStore: YearsStoreProtocol {
    func fetchYears(then handler: (Result<[Date], Error>) -> ()) {
        let calendar = Calendar.current
        let currentDate = Date()
        let lastYear = calendar.date(byAdding: .year, value: -1, to: currentDate)
        let nextYear = calendar.date(byAdding: .year, value: 1, to: currentDate)
        let years = [lastYear, currentDate, nextYear].compactMap({ date in date })

        handler(.success(years))
    }
}
