//
//  YearsMemoryStore.swift
//  Calendar
//
//  Created by Rafael Ferreira on 12/31/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

final class YearsMemoryStore: YearsStoreProtocol {
    private let calendar = Calendar.current

    // MARK: YearsStoreProtocol conforms

    func fetchYears(then handler: (Result<[Date], Error>) -> ()) {
        let currentDate = Date()
        let lastYear = calendar.date(byAdding: .year, value: -1, to: currentDate)
        let nextYear = calendar.date(byAdding: .year, value: 1, to: currentDate)
        let years = [lastYear, currentDate, nextYear].compactMap({ date in date })

        handler(.success(years))
    }

    func fetchMonths(for year: Date, then handler: (Result<[Date], Error>) -> ()) {
        var months: [Date] = []

        if let firstDayOfMonth = calendar.date(bySetting: .day, value: 1, of: year) {
            (1...12).forEach { month in
                if let currentMonth = calendar.date(bySetting: .month, value: month, of: firstDayOfMonth) {
                    months.append(currentMonth)
                }
            }
        }

        handler(.success(months))
    }
}
