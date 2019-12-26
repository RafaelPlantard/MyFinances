//
//  IncomeListModels.swift
//  Income
//
//  Created by Rafael Ferreira on 12/26/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

enum IncomeList {
    enum FetchIncomes {
        struct Response {
            let incomes: [Income]
        }

        struct ViewModel {
            struct DisplayedIncome {
                let name: String
                let value: String?
            }

            let displayedIncomes: [DisplayedIncome]
        }
    }
}
