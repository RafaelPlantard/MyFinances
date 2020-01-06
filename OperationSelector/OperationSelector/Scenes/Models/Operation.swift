//
//  Operation.swift
//  OperationSelector
//
//  Created by Rafael Ferreira on 1/5/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

enum Operation: CustomStringConvertible {
    case income

    var description: String {
        switch self {
        case .income: return Localizable.List.Operations.income
        }
    }
}
