//
//  AddIncomeModels.swift
//  Income
//
//  Created by Rafael Ferreira on 12/23/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

enum AddIncome {
    struct IncomeFormFields {
        let name: String
        let amount: Double
        let date: Date
    }

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

    enum SaveNewIncome {
        struct Request {
            let incomeFormFields: IncomeFormFields
        }
    }

    enum ValidateNewIncome {
        struct Request {
            let incomeFormFields: IncomeFormFields
        }

        struct Response {
            let isValid: Bool
        }

        struct ViewModel {
            let isEnabled: Bool
        }
    }
}
