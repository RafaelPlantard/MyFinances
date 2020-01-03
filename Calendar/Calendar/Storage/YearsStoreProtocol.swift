//
//  YearsStoreProtocol.swift
//  Calendar
//
//  Created by Rafael Ferreira on 12/31/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

protocol YearsStoreProtocol {
    func fetchYears(then handler: (Result<[Date], Error>) -> Void)
    func fetchMonths(for year: Date, then handler: (Result<[Date], Error>) -> Void)
}
