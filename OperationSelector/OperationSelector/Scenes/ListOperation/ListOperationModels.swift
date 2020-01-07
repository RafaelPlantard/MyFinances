//
//  ListOperationModels.swift
//  OperationSelector
//
//  Created by Rafael Ferreira on 1/5/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

enum ListOperation {
    enum FetchOperations {
        struct Response {
            let operations: [Operation]
        }

        struct ViewModel {
            let operations: [String]
        }
    }

    enum SelectOperation {
        struct Request {
            let indexPath: IndexPath
        }
    }
}
