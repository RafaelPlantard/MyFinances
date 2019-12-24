//
//  AddIncomeModels.swift
//  Income
//
//  Created by Rafael Ferreira on 12/23/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

enum AddIncome{
    enum FormatDate {
        struct Request {
            let date: Date
        }

        struct Response {
            let date: Date
        }

        struct ViewModel {
            let date: String
        }
    }
}
