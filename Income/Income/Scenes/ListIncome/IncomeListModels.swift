//
//  IncomeListModels.swift
//  Income
//
//  Created by Rafael Ferreira on 12/26/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

import class UIKit.UITableViewCell

protocol DisplayIncomeList {
    var name: String { get }
    var value: String? { get }
}

enum IncomeList {
    enum FetchIncomes {
        struct Response {
            let incomes: [Income]
        }

        struct ViewModel {
            struct DisplayedIncome: DisplayIncomeList {
                let name: String
                let value: String?
            }

            let displayedIncomes: [DisplayedIncome]
        }
    }

    enum DeleteIncome {
        struct Request {
            let style: UITableViewCell.EditingStyle
            let indexPath: IndexPath
        }

        struct Response {
            let incomes: [Income]
            let deletedIndexPath: IndexPath
        }

        struct ViewModel {
            struct DisplayedIncome: DisplayIncomeList {
                let name: String
                let value: String?
            }

            let displayedIncomes: [DisplayedIncome]
            let deletedIndexPath: IndexPath
        }
    }
}
