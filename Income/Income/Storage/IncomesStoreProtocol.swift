//
//  IncomesStoreProtocol.swift
//  Income
//
//  Created by Rafael Ferreira on 12/25/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

protocol IncomesStoreProtocol {
    func fetchIncomes(then handler: (Result<[Income], Error>) -> Void)
    func save(income: Income, then handler: (Result<Void, Error>) -> Void)
    func deleteIncome(id: String, then handler: (Result<Void, Error>) -> Void)
}

enum IncomesStoreError: Error {
    case cannotDelete
}
