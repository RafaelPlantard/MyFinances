//
//  OperationsStoreProtocol.swift
//  OperationSelector
//
//  Created by Rafael Ferreira on 1/5/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

protocol OperationsStoreProtocol {
    func fetchOperations(then handler: (Result<[Operation], Error>) -> Void)
}
