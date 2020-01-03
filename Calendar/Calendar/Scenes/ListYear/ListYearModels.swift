//
//  ListYearModels.swift
//  Calendar
//
//  Created by Rafael Ferreira on 12/31/19.
//  Copyright © 2019 Swift Yah. All rights reserved.
//

enum ListYear {
    enum FetchYears {
        struct Response {
            let dates: [Date]
        }

        struct ViewModel {
            let years: [String]
        }
    }

    enum FetchMonths {
        struct Request {
            let indexPath: IndexPath
        }

        struct Response {
            let year: Date
            let months: [Date]
        }

        struct ViewModel {
            let year: String
            let months: [String]
        }
    }

    enum ChangeRange {
        struct Request {
            let index: Int
        }
    }
}
